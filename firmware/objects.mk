#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2019 Western Digital Corporation or its affiliates.
#
# Authors:
#   Anup Patel <anup.patel@wdc.com>
#

firmware-genflags-y =
firmware-cppflags-y +=
firmware-cflags-y +=
firmware-asflags-y +=
firmware-ldflags-y +=

ifdef FW_TEXT_START
firmware-genflags-y += -DFW_TEXT_START=$(FW_TEXT_START)
else
firmware-genflags-y += -DFW_TEXT_START=0x0
endif

ifdef FW_FDT_PATH
firmware-genflags-y += -DFW_FDT_PATH=\"$(FW_FDT_PATH)\"
ifdef FW_FDT_PADDING
firmware-genflags-y += -DFW_FDT_PADDING=$(FW_FDT_PADDING)
endif
endif

firmware-bins-$(FW_DYNAMIC) += fw_dynamic.bin

firmware-bins-$(FW_JUMP) += fw_jump.bin
ifdef FW_JUMP_OFFSET
firmware-genflags-$(FW_JUMP) += -DFW_JUMP_OFFSET=$(FW_JUMP_OFFSET)
endif
ifdef FW_JUMP_ADDR
firmware-genflags-$(FW_JUMP) += -DFW_JUMP_ADDR=$(FW_JUMP_ADDR)
endif
ifdef FW_JUMP_FDT_OFFSET
firmware-genflags-$(FW_JUMP) += -DFW_JUMP_FDT_OFFSET=$(FW_JUMP_FDT_OFFSET)
endif
ifdef FW_JUMP_FDT_ADDR
firmware-genflags-$(FW_JUMP) += -DFW_JUMP_FDT_ADDR=$(FW_JUMP_FDT_ADDR)
endif

firmware-bins-$(FW_PAYLOAD) += fw_payload.bin
ifdef FW_PAYLOAD_PATH
FW_PAYLOAD_PATH_FINAL=$(FW_PAYLOAD_PATH)
else
FW_PAYLOAD_PATH_FINAL=$(platform_build_dir)/firmware/payloads/test.bin
endif
firmware-genflags-$(FW_PAYLOAD) += -DFW_PAYLOAD_PATH=\"$(FW_PAYLOAD_PATH_FINAL)\"
ifdef FW_PAYLOAD_OFFSET
firmware-genflags-$(FW_PAYLOAD) += -DFW_PAYLOAD_OFFSET=$(FW_PAYLOAD_OFFSET)
endif
ifdef FW_PAYLOAD_ALIGN
firmware-genflags-$(FW_PAYLOAD) += -DFW_PAYLOAD_ALIGN=$(FW_PAYLOAD_ALIGN)
endif

ifdef FW_PAYLOAD_FDT_OFFSET
firmware-genflags-$(FW_PAYLOAD) += -DFW_PAYLOAD_FDT_OFFSET=$(FW_PAYLOAD_FDT_OFFSET)
endif
ifdef FW_PAYLOAD_FDT_ADDR
firmware-genflags-$(FW_PAYLOAD) += -DFW_PAYLOAD_FDT_ADDR=$(FW_PAYLOAD_FDT_ADDR)
endif

ifdef FW_OPTIONS
firmware-genflags-y += -DFW_OPTIONS=$(FW_OPTIONS)
endif

ifeq ($(CONFIG_STACK_PROTECTOR),y)
stack-protector-cflags-$(CONFIG_STACK_PROTECTOR) := -fstack-protector
stack-protector-cflags-$(CONFIG_STACK_PROTECTOR_STRONG) := -fstack-protector-strong
stack-protector-cflags-$(CONFIG_STACK_PROTECTOR_ALL) := -fstack-protector-all
else
stack-protector-cflags-y := -fno-stack-protector
endif
firmware-cflags-y += $(stack-protector-cflags-y)
