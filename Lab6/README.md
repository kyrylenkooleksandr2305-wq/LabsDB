# Міграції бази даних з Flyway
Цей файл документує всі дії, які були виконані при виконанні лабораторної роботи
## 1. Створення нової міграції Medication
**Опис:** Створено нову таблицю Medication для оптимізації баз даних для того, щоб не дублювалися ліки, змінювати в 1 місці все, а також економить місце.
**Код SQL(```V5__create_medication_table.sql```):**
```sql
CREATE TABLE IF NOT EXISTS medication (
                                          medicationid SERIAL PRIMARY KEY,
                                          medicationname VARCHAR(100) NOT NULL UNIQUE,
                                          description TEXT
);

ALTER TABLE treatment ADD COLUMN IF NOT EXISTS medicationid INTEGER;

ALTER TABLE treatment ADD CONSTRAINT fk_treatment_medication
    FOREIGN KEY (medicationid) REFERENCES medication(medicationid);

## 2.Додавання статусу лікування
**Опис:** Додавання колонки статусу для відслідковування лікування.
**Код SQL(```V2__add_treatment_status.sql```):**
```sql
ALTER TABLE treatment ADD COLUMN IF NOT EXISTS status VARCHAR(20) DEFAULT 'Active';```

## 3.Додавання колонок контактів
**Опис:** Створено нові контакти пацієнтів для більшої інформованості
**Код SQL(```V5__add_patient_contacts.sql```):**
```sql
ALTER TABLE patient ADD COLUMN IF NOT EXISTS phone VARCHAR(20);
ALTER TABLE patient ADD COLUMN IF NOT EXISTS email VARCHAR(100) UNIQUE;```

## 4.Видалення застарілого поля Medication
**Опис:** Видалено непотрібне поле Medication натомість створено нову таблицю.
**Код SQL(```V5_drop_old_medication_field.sql```):**
```sql
ALTER TABLE treatment DROP COLUMN IF EXISTS medication;```

## 4. Результати
**Нова таблиця Medication:**
<img width="391" height="387" alt="image" src="https://github.com/user-attachments/assets/bd67f368-4ee4-4c92-b78b-aeae20370adf" />
**Доданий статус лікування:**
<img width="987" height="216" alt="image" src="https://github.com/user-attachments/assets/5b07527e-7adb-4926-bd8b-577d461215e0" />
**Додані контакти пацієнтів:**
<img width="1210" height="212" alt="image" src="https://github.com/user-attachments/assets/22fc35fc-072d-4269-8f9e-b2c22e1da7be" />
**Видалений стовпець Medication з таблиці Treatment:**
<img width="542" height="482" alt="image" src="https://github.com/user-attachments/assets/e3472b4a-9140-48e3-af08-cea2c2fe447b" />
<img width="986" height="210" alt="image" src="https://github.com/user-attachments/assets/5bd2e1a4-ad7f-4514-8f58-68305534ca84" />
**Структура в IntellIJ:**
<img width="502" height="547" alt="image" src="https://github.com/user-attachments/assets/12afa4d5-7406-4a8d-a280-aa8d2c5bfa7d" />
**Результати в консолі:**
<img width="1635" height="880" alt="image" src="https://github.com/user-attachments/assets/15a576ce-8bca-4553-8223-dfdc58da38f2" />
<img width="1762" height="483" alt="image" src="https://github.com/user-attachments/assets/0d814b29-577d-4e35-8ddc-6dddbf857ab0" />
