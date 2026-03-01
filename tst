import java.util.*;

public class Main {

    // Структура результата
    static class Result {
        int start;
        int length;

        Result(int start, int length) {
            this.start = start;
            this.length = length;
        }
    }

    // ================== ОСНОВНАЯ ФУНКЦИЯ ==================
    public static Result solution(int[] arr) {
        if (arr == null || arr.length == 0) {
            return new Result(-1, 0);
        }

        List<Result> candidates = new ArrayList<>();

        int start = 0;
        int length = 1;

        for (int i = 1; i < arr.length; i++) {

            if (i == start + 1) {
                // первые два элемента всегда чередуются
                if (arr[i] != arr[i - 1]) {
                    length++;
                } else {
                    candidates.add(new Result(start, length));
                    start = i;
                    length = 1;
                }
            } else {
                // проверка настоящего чередования A B A B
                if (arr[i] == arr[i - 2] && arr[i] != arr[i - 1]) {
                    length++;
                } else {
                    candidates.add(new Result(start, length));
                    start = i - 1;
                    length = 2;

                    // если два одинаковых подряд
                    if (arr[i] == arr[i - 1]) {
                        start = i;
                        length = 1;
                    }
                }
            }
        }

        candidates.add(new Result(start, length));

        // ищем максимальную длину
        int maxLen = 0;
        for (Result r : candidates) {
            maxLen = Math.max(maxLen, r.length);
        }

        // собираем все максимальные
        List<Result> maxList = new ArrayList<>();
        for (Result r : candidates) {
            if (r.length == maxLen) {
                maxList.add(r);
            }
        }

        if (maxList.isEmpty()) return new Result(-1, 0);

        if (maxList.size() == 1) return maxList.get(0);

        // вторая справа
        return maxList.get(maxList.size() - 2);
    }

    // ================== ВСПОМОГАТЕЛЬНЫЕ ==================
    public static int[] readArray(Scanner sc) {
        System.out.print("Введите размер массива: ");
        int n = sc.nextInt();
        int[] arr = new int[n];

        System.out.println("Введите элементы массива:");
        for (int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }
        return arr;
    }

    public static void printArray(int[] arr) {
        System.out.print("{ ");
        for (int x : arr) {
            System.out.print(x + " ");
        }
        System.out.println("}");
    }

    public static void printSubArray(int[] arr, Result r) {
        if (r.start == -1) {
            System.out.println("Подпоследовательность не найдена");
            return;
        }
        System.out.print("Результат: { ");
        for (int i = r.start; i < r.start + r.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println("}");
        System.out.println("Старт = " + r.start + ", длина = " + r.length);
    }

    // ================== ТЕСТЫ ==================
    public static void runTests() {
        int[][] tests = {
                {4, 6, 1, 2, 1, 2, 3, 2, 3, 5, 4, 7, 4, 1, 5, 1, 5, 6},
                {1, 1, 1, 1},
                {1, 2, 3, 4, 5},
                {5, 5, 5, 6, 6, 7},
                {1},
                {},
                {1, 2, 1, 2, 1, 2},
                {3, 3, 2, 2, 1, 1},
                {1, 2, 2, 3, 3, 4, 4, 5},
                {9, 8, 9, 8, 9, 8, 7}
        };

        for (int i = 0; i < tests.length; i++) {
            System.out.println("\nТест #" + (i + 1));
            printArray(tests[i]);
            Result res = solution(tests[i]);
            printSubArray(tests[i], res);
        }
    }

    // ================== MAIN ==================
    public static void main(String[] args) {

        // если есть аргументы командной строки
        if (args.length > 0) {
            int[] arr = Arrays.stream(args).mapToInt(Integer::parseInt).toArray();
            Result res = solution(arr);
            printArray(arr);
            printSubArray(arr, res);
            return;
        }

        // запуск тестов
        runTests();

        // ввод пользователя
        Scanner sc = new Scanner(System.in);
        int[] userArr = readArray(sc);

        Result res = solution(userArr);
        printArray(userArr);
        printSubArray(userArr, res);
    }
}
