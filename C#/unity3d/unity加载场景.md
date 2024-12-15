## unity加载场景

##### 1.制作加载界面

> 在`Resources`目录添加预制体`Loading`

<img src="../../assets/image-20241215204533166.png" alt="image-20241215204533166" style="zoom:50%;" />



##### 2.SceneController类

```c#
public class SceneController : MonoBehaviour
{

    private string sceneName;
    public event Action<float> onProgressChanged;
    public event Action onFinished;
    public bool isAA;

    private static SceneController _instance;
    public static SceneController Instance
    {
        get
        {
            if (_instance == null)
            {
                GameObject gp = new GameObject("SceneController");
                gp.AddComponent<SceneController>();
            }
            return _instance;
        }
    }

    private void Awake()
    {
        if (_instance != null && _instance != this)
        {
            Debug.LogError("场景存在 SceneController");
            Destroy(gameObject);
            return;
        }
        _instance = this;
        DontDestroyOnLoad(gameObject);
    }

    /// <summary>
    /// 加载场景
    /// </summary>
    /// <param name="sceneName">场景名称</param>
    /// <param name="onProgressChange">进度回调</param>
    /// <param name="onFinish">完成回调</param>
    /// <param name="isAA">是否加载AA包场景</param>
    public void LoadScene(string sceneName, Action<float> onProgressChange = null, Action onFinish = null,bool isAA = false)
    {
        this.sceneName = sceneName;
        this.isAA = isAA;
        if (onProgressChange != null) onProgressChanged += onProgressChange;
        if (onFinish != null) onFinished += onFinish;

        StartCoroutine(LoadScene());
    }

    private IEnumerator LoadScene()
    {
        yield return new WaitForSeconds(0.1f);
        // 是否AA包
        if (!isAA)
        {
            AsyncOperation asyncOperation1 = SceneManager.LoadSceneAsync(sceneName);
            while (!asyncOperation1.isDone)
            {
                yield return new WaitForSeconds(0.1f);
                onProgressChanged?.Invoke(asyncOperation1.progress);
            }
        }
        else
        {
            AsyncOperationHandle<SceneInstance> asyncOperation = Addressables.LoadSceneAsync(sceneName);
            while (!asyncOperation.IsDone)
            {
                yield return new WaitForSeconds(0.1f);
                onProgressChanged?.Invoke(asyncOperation.PercentComplete);
            }

            // 加载完成
            if (asyncOperation.Status != AsyncOperationStatus.Succeeded)
            {
                Debug.LogError("Failed to load scene: " + asyncOperation.OperationException);
            }
        }

        yield return new WaitForSeconds(0.2f);

        
        onFinished?.Invoke();
        onProgressChanged = null; // 清理事件，避免多余订阅
        onFinished = null;        // 清理事件，避免多余订阅
    }
}
```

##### 3.LoadingView类

```C#

public class LoadingView : ViewBase
{
    private static Slider progressBar;
    private static TextMeshProUGUI progressText;
    private static LoadingView _instance;

    // Singleton Instance property
    public static LoadingView Instance
    {
        get
        {
            // 如果LoadingView还没加载，则异步加载
            if (_instance == null)
            {
                LoadLoadingView();
            }
            return _instance;
        }
    }

    // 加载LoadingView并创建实例
    private static void LoadLoadingView()
    {
        if (_instance != null) return;
        
        // 加载一个Prefab资源
        GameObject loadedPrefab = Resources.Load<GameObject>("Prefabs/Loading");
        if (loadedPrefab == null)
        {
            Debug.LogError("LoadingView: Failed to load prefab.");
        }

        // 实例化Loading UI
        GameObject canvas = Instantiate(loadedPrefab);
        _instance = canvas.AddComponent<LoadingView>();

        // 获取UI组件
        progressText = canvas.GetComponentInChildren<TextMeshProUGUI>();
        progressBar = canvas.GetComponentInChildren<Slider>();
        DontDestroyOnLoad(canvas); // 保持LoadingView在场景之间持续
    }

    private void UpdateProgress(float progress)
    {
        if (progressBar != null && progressText != null)
        {
            progressBar.value = progress;
            progressText.text = $"{Mathf.Round(progress * 100)}%";
        }
    }

    public void LoadScene(string sceneName, bool isAA = false)
    {
        if (_instance != null)
        {
            _instance.Show();
        }

        // 使用SceneController来加载场景，并更新加载进度
        SceneController.Instance.LoadScene(sceneName, (progress) =>
        {
            if (_instance != null)
            {
                _instance.UpdateProgress(progress);
            }
        }, () =>
        {
            if (_instance != null)
            {
                _instance.Hide();
            }
        }, isAA);
    }
}
```



