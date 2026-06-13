## การทำงานของสคริปต์

### kill-node.bat

1. `@echo off`
   - ปิดการแสดงคำสั่งก่อนรัน เพื่อให้ output สะอาด

2. `setlocal enabledelayedexpansion`
   - เปิดโหมดที่อนุญาตให้ใช้ตัวแปรภายในลูปได้

3. `tasklist /FI "IMAGENAME eq node.exe" /FO CSV /NH | find /I "node.exe"`
   - ดึงรายการ process ชื่อ `node.exe`
   - แปลงผลเป็น CSV แล้วกรองเฉพาะ `node.exe`

4. บล็อก `for /f ...`
   - อ่านแต่ละบรรทัดของคำสั่งก่อนหน้า
   - เก็บชื่อ process และ PID ลงในตัวแปรลำดับ `proc_pid[1]`, `proc_pid[2]`, ...
   - แสดงรายการเป็นเลข `1. node.exe (PID 1234)`

5. `if %count%==0`
   - ถ้าไม่พบ process เลย จะแสดงว่าไม่พบ แล้วหยุดสคริปต์

6. `set /p choice=...`
   - ขอ input จากผู้ใช้ ให้ป้อน
   - `A` = kill all
   - `Q` = ยกเลิก
   - หรือหมายเลข process ที่ต้องการหยุด

7. `if /I "%choice%"=="Q"`
   - ถ้าเลือก `Q` จะยกเลิกและไม่ทำอะไร

8. `if /I "%choice%"=="A"`
   - ถ้าเลือก `A` จะสั่ง `taskkill /F /IM node.exe`
   - หยุด process ทุกตัวที่ชื่อ `node.exe`

9. ลูป `for /L %%I in (1,1,%count%)`
   - ถ้าผู้ใช้ใส่ตัวเลข จะหา PID ที่ตรงกับหมายเลขนั้น

10. `if not defined pid`
    - ถ้าป้อนหมายเลขไม่ถูกต้อง จะบอกว่าเป็น input ไม่ถูกต้อง

11. `taskkill /F /PID %pid%`
    - หยุดเฉพาะ process ที่ผู้ใช้เลือก
    - ไม่ kill all ถ้าผู้ใช้ป้อนหมายเลข

12. `pause`
    - หน้าต่างจะไม่ปิดทันทีหลังรันเสร็จ
    - ผู้ใช้กด Enter เพื่อออกเอง

---

### kill-node.ps1

1. `Get-Process -Name node -ErrorAction SilentlyContinue`
   - ดึง process `node` ทั้งหมด
   - ถ้าไม่เจอจะไม่แสดง error

2. ถ้าไม่มี process
   - แสดงข้อความว่าไม่มี
   - รอผู้ใช้กด Enter ก่อนปิด

3. แสดงรายการ process
   - ใช้ `Write-Host` พร้อมหมายเลข
   - เช่น `1. node (PID 1234) Started: ...`

4. `Read-Host "Enter process number to kill, A=all, Q=quit"`
   - ให้ผู้ใช้เลือก
   - `A` = kill all
   - `Q` = ยกเลิก
   - หมายเลข = kill process เฉพาะตัว

5. ถ้าเลือก `Q`
   - ยกเลิกโดยไม่หยุด process ใด ๆ

6. ถ้าเลือก `A`
   - สั่ง `Stop-Process -Force` ทั้งหมด

7. ถ้าเลือกหมายเลข
   - แปลงเป็น index แล้วเลือก process นั้น
   - ถ้าเลขไม่ถูกต้อง จะแจ้ง error
   - ถ้าถูกต้อง จะหยุด process เฉพาะ PID ที่เลือก

8. `Read-Host "Press Enter to close..."`
   - รอผู้ใช้ก่อนปิด เพื่อให้เห็นผลลัพธ์

---

## สรุปการใช้งานแบบไม่ kill all

### หยุด process เดียวด้วย kill-node.bat
1. เปิด PowerShell
2. เข้าโฟลเดอร์ `Kill-Node`
3. รัน:
   - kill-node.bat
4. เมื่อเห็นรายการ process
   - พิมพ์หมายเลข process ที่ต้องการหยุด
   - กด Enter

### หยุด process เดียวด้วย kill-node.ps1
1. เปิด PowerShell
2. เข้าโฟลเดอร์ `Kill-Node`
3. รัน:
   - kill-node.ps1
4. เมื่อเห็นรายการ process
   - พิมพ์หมายเลข process ที่ต้องการหยุด
   - กด Enter

### คำอธิบายหลัก
- `A` = หยุดทั้งหมด
- `Q` = ยกเลิก
- ตัวเลข = หยุดเฉพาะ process ที่เลือก
- ถ้าเลือกตัวเลขไม่ถูกต้อง มันจะแจ้งว่า input ผิด
- ทั้ง 2 สคริปต์จะรอให้กด Enter ก่อนปิด เพื่อให้คุณเห็นผลลัพธ์