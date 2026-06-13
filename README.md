# Kill Node.js processes with ease.

เคยไหมที่ทำงานอยู่ดีๆ เครื่องค้างจากการรัน Node.js เบื้องหลังจำนวนมากโดย AI รันไว้แล้วไม่ยอมปิดหลังทดสอบงานเสร็จ แล้วมันก็ตีเนียนทำงานต่อ กว่าเราจะรู้ตัวว่ามี process ที่ทำงานค้างกินทรัพยากรเครื่องอยู่ เครื่องอืด หรือ ค้างแล้ว

ถ้าต้องการหยุด Node.js process ที่กำลังทำงานอยู่ แต่ไม่รู้ว่าจะใช้คำสั่งอะไร หรือไม่อยากเปิด Task Manager เพื่อหากระบวนการที่ต้องการหยุด? `kill-node` เป็นเครื่องมือช่วยให้คุณสามารถหยุด Node.js processes ได้อย่างง่ายดายและรวดเร็ว!

## What is included

- `kill-node.bat` — Batch script สำหรับ Windows
- `kill-node.ps1` — PowerShell script สำหรับ Windows

## How it works

1. ตรวจสอบว่ามี process `node.exe` กำลังรันอยู่หรือไม่
2. ถ้าเจอ จะแสดงรายการ Node.js process ที่กำลังทำงาน
3. เลือกหมายเลขเพื่อหยุด process เดียว หรือกด `A` เพื่อหยุดทั้งหมด
4. ถ้าเลือก `Q` หรือไม่มี process จะยกเลิกโดยไม่ทำอะไร

## Usage

### Run batch script

1. เปิด Command Prompt หรือ PowerShell
2. ไปที่โฟลเดอร์โปรเจคนี้
3. รัน:

- ใน Command Prompt:

```bat
kill-node.bat
```

- ใน PowerShell:

```powershell
.\kill-node.bat
```

> ใน PowerShell ต้องเพิ่ม `.
` หน้าไฟล์เสมอ เพราะ PowerShellไม่รันคำสั่งจากโฟลเดอร์ปัจจุบันโดยไม่ระบุเส้นทาง

### Run PowerShell script

1. เปิด PowerShell
2. ไปที่โฟลเดอร์โปรเจคนี้
3. รัน:

```powershell
.\kill-node.ps1
```

> หาก PowerShell ปิดการรันสคริปต์ไว้ ให้ตั้งค่า execution policy ชั่วคราวด้วย:
>
> ```powershell
> Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
> ```

## วิธีเลือก kill process แบบไม่ kill all

### ใน kill-node.bat
- รัน kill-node.bat ใน PowerShell หรือ kill-node.bat ใน CMD
- จะเห็นรายการหมายเลข `1`, `2`, `3`, ...
- ถ้าต้องการหยุดเฉพาะ process ใด ให้พิมพ์หมายเลขนั้นแล้วกด Enter
- ไม่ต้องพิมพ์ `A`
- ถ้าอยากยกเลิก พิมพ์ `Q`

ตัวอย่าง:
- `2` = หยุดเพียง process ที่เป็นหมายเลข 2
- `A` = หยุดทุก `node.exe`
- `Q` = ยกเลิก

### ใน kill-node.ps1
- รัน kill-node.ps1
- จะเห็นรายการ process พร้อมหมายเลข
- พิมพ์หมายเลขที่ต้องการหยุด
- ถ้าอยากหยุดทั้งหมด ให้พิมพ์ `A`
- ถ้าอยากยกเลิก ให้พิมพ์ `Q`

---

## สรุป
ถ้าไม่อยาก kill all ให้ป้อน "หมายเลข" ที่แสดงในรายการ
อย่าใส่ `A` ถ้าไม่ต้องการ kill all
และใน PowerShell ให้เรียกไฟล์ด้วย kill-node.bat หรือ kill-node.ps1

## Note

- สคริปต์นี้จะหยุดโปรเซส Node.js ทุกตัวในระบบ
- ใช้เฉพาะเวลาที่ต้องการเคลียร์ process Node.js ที่ค้างอยู่
- ควรใช้อย่างระมัดระวังเมื่อรันบนเครื่องที่มีงานสำคัญกำลังทำงานอยู่ด้วย Node.js



