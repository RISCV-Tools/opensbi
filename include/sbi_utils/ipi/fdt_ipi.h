/*
 * SPDX-License-Identifier: BSD-2-Clause
 *
 * Copyright (c) 2020 Western Digital Corporation or its affiliates.
 *
 * Authors:
 *   Anup Patel <anup.patel@wdc.com>
 */

#ifndef __FDT_IPI_H__
#define __FDT_IPI_H__

#include <sbi/sbi_types.h>

#ifdef CONFIG_FDT_IPI

struct fdt_ipi {
	const struct fdt_match *match_table;
	int (*cold_init)(const void *fdt, int nodeoff, const struct fdt_match *match);
	int (*warm_init)(void);
	void (*exit)(void);
};

void fdt_ipi_exit(void);

int fdt_ipi_init(bool cold_boot);

#else

static inline void fdt_ipi_exit(void) { }
static inline int fdt_ipi_init(bool cold_boot) { return 0; }

#endif

#endif
