## forkJoin

> Fork/Join框架是Java7提供了的一个用于并行执行任务的框架， 是一个把大任务分割成若干个小任务，最终汇总每个小任务结果后得到大任务结果的框架。

#### 例如 循环每次加10操作:

```java
public class RecursiveTaskTest extends RecursiveTask<Long> {
    int max = 100000;
    long number;

    public RecursiveTaskTest(long number){
        this.number = number;
    }
    @Override
    protected Long compute() {
        if(number < max){
            long result = 0L;
            for (int i = 0; i < number; i++) {
                result += 10;
            }
            System.out.println("for");
            return result;
        }
        System.out.println("forkJoin");

        long l = number / 2;
        long l1 = number % 2;
        System.out.println(": ->" + l1);


        RecursiveTaskTest task = new RecursiveTaskTest(l1 != 0 ? l +1 : l);
        task.fork();

        RecursiveTaskTest task1 = new RecursiveTaskTest(l);
        task1.fork();

        Long join = task.join();
        Long join2 = task1.join();
        return join + join2;
    }

    public static void main(String[] args) throws ExecutionException, InterruptedException {
        ForkJoinPool pool = new ForkJoinPool();
        RecursiveTaskTest recursiveTaskTest = new RecursiveTaskTest(9000000000L);
        ForkJoinTask<Long> submit = pool.submit(recursiveTaskTest);
        Long aLong = submit.get();
        System.out.println(aLong);

    }
}
```

