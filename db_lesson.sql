-- Q1: 部署テーブルの作成
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Q2: 部署データの追加
INSERT INTO departments (name) VALUES ('営業'), ('開発'), ('経理'), ('人事'), ('情報システム');

-- Q3: peopleテーブルにdepartment_idカラムを追加
ALTER TABLE people ADD department_id INT AFTER email;

-- Q4: NULLだったdepartment_idを更新
UPDATE people SET department_id = 1 WHERE person_id IN (1, 2, 3);
UPDATE people SET department_id = 2 WHERE person_id = 4;
UPDATE people SET department_id = 4 WHERE person_id = 6;

-- (追加作業：データを綺麗にするためのフルネーム更新と新メンバー追加)
UPDATE people SET name = '伊藤 健太' WHERE person_id = 7;
UPDATE people SET name = '渡辺 まりこ' WHERE person_id = 8;
UPDATE people SET name = '山本 雄大' WHERE person_id = 9;
UPDATE people SET name = '中村 恵子' WHERE person_id = 10;
UPDATE people SET name = '加藤 浩志' WHERE person_id = 11;
INSERT INTO people (name, email, department_id, age, gender) VALUES ('佐藤 次郎', 'jiro@example.com', 1, 22, 1);

-- Q5: 男性（gender=1）を年齢の降順で取得
SELECT name, age FROM people WHERE gender = 1 ORDER BY age DESC;

-- Q6: SQL文の説明（日本語回答）
-- 「peopleテーブルから、department_idが1のレコードを抽出し、name・email・ageカラムをcreated_atの昇順で取得する」

-- Q7: 20代の女性と40代の男性の名前一覧
SELECT name FROM people 
WHERE (gender = 2 AND age >= 20 AND age < 30)
OR (gender = 1 AND age >= 40 AND age < 50);

-- Q8: 営業部(ID:1)の人を年齢の昇順で取得
SELECT * FROM people WHERE department_id = 1 ORDER BY age ASC;

-- Q9: 開発部(ID:2)の女性の平均年齢
SELECT AVG(age) AS average_age FROM people WHERE department_id = 2 AND gender = 2;

-- Q10: 名前・部署名・日報内容を結合して取得
SELECT p.name, d.name AS department_name, r.content 
FROM people AS p
INNER JOIN departments AS d ON p.department_id = d.department_id
INNER JOIN reports AS r ON p.person_id = r.person_id;

-- Q11: 日報を一つも提出していない人の名前一覧
-- (不思議沢さんの日報を削除した状態で実行)
DELETE FROM reports WHERE person_id = 6;
SELECT p.name FROM people AS p
LEFT JOIN reports AS r ON p.person_id = r.person_id
WHERE r.repot_id IS NULL;