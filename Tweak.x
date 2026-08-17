#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <substrate.h>

// =========================================================
// CHỈ CẦN CẬP NHẬT OFFSET TẠI ĐÂY KHI GAME UPDATE
// =========================================================
#define PATCH_OFFSET 0x1002334C0 // Thay offset lệnh B.EQ tìm từ Ghidra vào đây

// Hàm tính địa chỉ thực tế theo ASLR Slide
uintptr_t get_real_address(uintptr_t address) {
    uintptr_t slide = _dyld_get_image_vmaddr_slide(0);
    return slide + address;
}

%ctor {
    @autoreleasepool {
        // Lấy địa chỉ thực tế trong RAM
        uintptr_t target_addr = get_real_address(PATCH_OFFSET);

        // Mã máy NOP cho ARM64 (0x1F2003D5 -> Little Endian: 0xD503201F)
        uint32_t nop_instruction = 0xD503201F;

        // Ghi đè vào bộ nhớ (Live Patch)
        MSHookMemory((void *)target_addr, &nop_instruction, sizeof(nop_instruction));
    }
}
