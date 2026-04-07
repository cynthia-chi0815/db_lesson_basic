-- Q1: 部署テーブルの作成
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Q2: peopleテーブルにdepartment_idカラムを追加
ALTER TABLE people ADD department_id INT AFTER email;

-- Q3: 部署データの追加
INSERT INTO departments (name) VALUES ('営業'), ('開発'), ('人事'), ('情報システム');

--追加する人の条件(people)
INSERT INTO people (person_id, department_id, name, email, age, gender) VALUES
(7, 2, '伊藤 健太', 'ito@example.com', 28, 1),
(8, 2, '渡辺 まりこ', 'watanabe@example.com', 32, 2),
(9, 2, '山本 雄大', 'yamamoto@example.com', 40, 1),
(10, 3, '中村 恵子', 'nakamura@example.com', 45, 2),
(11, 5, '加藤 浩志', 'kato@example.com', 33, 1),
(12, 1, '佐藤 健太', 'sato.kenta@example.com', 25, 1),
(13, 1, '鈴木 結衣', 'suzuki.yui@example.com', 28, 2),
(14, 1, '高橋 直樹', 'takahashi.naoki@example.com', 32, 1),
(15, 2, '田中 美咲', 'tanaka.misaki@example.com', 24, 2),
(16, 4, '伊藤 陽子', 'ito.yoko@example.com', 29, 2);

--追加する日報の条件(reports)
INSERT INTO reports (person_id, content) VALUES
(1, '今日はお疲れ様でした。'),
(1, 'MySQLの勉強をしました。'),
(2, '環境構築について復習しました。'),
(2, '今日は気分転換に散歩をしました。'),
(3, '順調に学習を進められています。' ),
(3, 'レコード追加も慣れてきました。' ),
(999, '今日はHTMLとCSSの基礎を学んだ。'),
(1, 'テーブル作成をしました。' ),
(1, '今日はお休みでした。 ' ),
(2, 'MySQLが難しくて苦戦しています。'),
(3, '今日は内部結合について学んだ。'),
(1, '本日は営業回りで3件の成約をいただきました。'),
(2, '新規クライアントとの打ち合わせを1時間行いました。'),
(3, '既存顧客のアフターフォローを重点的に実施しました。'),
(4, 'システムの致命的なバグ修正とテストを完了しました。'),
(7, '開発チームの定例ミーティングに参加し進捗を報告。'),
(8, 'フロントエンドの新しいライブラリ導入を検討中。'),
(9, ' バックエンドのAPI設計をGitHubにプッシュ完了。'),
(10, '月次の経費精算書類をすべてまとめ、経理へ提出。'),
(11, '社内PCのセキュリティソフトの一斉更新を確認した。');

-- Q4: NULLだったdepartment_idを更新
UPDATE people SET department_id = 1 WHERE person_id IN (1, 2, 3);
UPDATE people SET department_id = 2 WHERE person_id = 4;
UPDATE people SET department_id = 4 WHERE person_id = 6;

-- Q5: 男性を年齢の降順で取得
SELECT name, age FROM people WHERE gender = 1 ORDER BY age DESC;

-- Q6: SQL文の説明
-- peopleテーブルから、department_idが1のレコードを抽出し、name・email・ageカラムをcreated_atの昇順で取得する

-- Q7: 20代の女性と40代の男性の名前一覧
SELECT name FROM people
WHERE (gender = 2 AND age >= 20 AND age < 30)
OR (gender = 1 AND age >= 40 AND age < 50);

-- Q8: 営業部の人を年齢の昇順で取得
SELECT * FROM people WHERE department_id = 1 ORDER BY age ASC;

-- Q9: 開発部の女性の平均年齢
SELECT AVG(age) AS average_age FROM people WHERE department_id = 2 AND gender = 2;

-- Q10: 名前・部署名・日報内容を結合して取得
SELECT people.name, departments.name, reports.content
FROM people
INNER JOIN departments ON people.department_id = departments.department_id
INNER JOIN reports ON people.person_id = reports.person_id;

-- Q11: 日報を一つも提出していない人の名前一覧
-- (不思議沢さんの日報を削除した状態で実行)
DELETE FROM reports WHERE person_id = 6;

SELECT p.name FROM people AS p
LEFT JOIN reports AS r ON p.person_id = r.person_id
WHERE r.repot_id IS NULL;