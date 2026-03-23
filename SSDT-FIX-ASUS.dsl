DefinitionBlock ("", "SSDT", 2, "HACK", "FIXASUS", 0x00000000)
{
    // 1. แก้ไข STAS Lookup Failure (บังคับให้ STAS มีค่าเป็น 1 เสมอ)
    External (STAS, IntObj)
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            STAS = One
        }
    }

    // 2. ปิด PMAX Device (แก้ PMAX._STA Panic)
    External (_SB.PMAX, DeviceObj)
    Scope (_SB.PMAX)
    {
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero) // ปิดการทำงานใน macOS
            }
            Else
            {
                Return (0x0F) // ให้ทำงานปกติใน Windows
            }
        }
    }
}
