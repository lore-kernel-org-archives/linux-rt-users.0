From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v7 2/7] MIPS: Differentiate between 32 and 64 bit ELF header
Date: Fri, 29 Jan 2016 15:03:23 +0100
Message-ID: <1454076208-28354-3-git-send-email-daniel.wagner@bmw-carit.de>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Maik Broemme <mbroemme@plusserver.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Depending on the configuration either the 32 or 64 bit version of
elf_check_arch() is defined. parse_crash_elf32_headers() does
some basic verification of the ELF header via elf_check_arch().
parse_crash_elf64_headers() does it via vmcore_elf64_check_arch()
which expands to the same elf_check_check().

   In file included from include/linux/elf.h:4:0,
                    from fs/proc/vmcore.c:13:
   fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
>> arch/mips/include/asm/elf.h:228:23: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     struct elfhdr *__h = (hdr);     \
                          ^
   include/linux/crash_dump.h:41:37: note: in expansion of macro 'elf_check_arch'
    #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
                                        ^
   fs/proc/vmcore.c:1015:4: note: in expansion of macro 'vmcore_elf64_check_arch'
      !vmcore_elf64_check_arch(&ehdr) ||
       ^

Since the MIPS ELF header for 32 bit and 64 bit differ we need
to check accordingly.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/mips/include/asm/elf.h | 68 ++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index b01a6ff..e311d60 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -205,27 +205,10 @@ struct mips_elf_abiflags_v0 {
 #define MIPS_ABI_FP_64		6	/* -mips32r2 -mfp64 */
 #define MIPS_ABI_FP_64A		7	/* -mips32r2 -mfp64 -mno-odd-spreg */
 
-#ifdef CONFIG_32BIT
-
-/*
- * In order to be sure that we don't attempt to execute an O32 binary which
- * requires 64 bit FP (FR=1) on a system which does not support it we refuse
- * to execute any binary which has bits specified by the following macro set
- * in its ELF header flags.
- */
-#ifdef CONFIG_MIPS_O32_FP64_SUPPORT
-# define __MIPS_O32_FP64_MUST_BE_ZERO	0
-#else
-# define __MIPS_O32_FP64_MUST_BE_ZERO	EF_MIPS_FP64
-#endif
-
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(hdr)						\
+#define elf_check_arch_32(hdr)						\
 ({									\
 	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
+	Elf32_Ehdr *__h = (hdr);					\
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
@@ -242,6 +225,40 @@ struct mips_elf_abiflags_v0 {
 	__res;								\
 })
 
+#define elf_check_arch_64(hdr)						\
+({									\
+	int __res = 1;							\
+	Elf64_Ehdr *__h = (hdr);					\
+									\
+	if (__h->e_machine != EM_MIPS)					\
+		__res = 0;						\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
+		__res = 0;						\
+									\
+	__res;								\
+})
+
+#define vmcore_elf64_check_arch(x)	(elf_check_arch_64(x) || vmcore_elf_check_arch_cross(x))
+
+#ifdef CONFIG_32BIT
+
+/*
+ * In order to be sure that we don't attempt to execute an O32 binary which
+ * requires 64 bit FP (FR=1) on a system which does not support it we refuse
+ * to execute any binary which has bits specified by the following macro set
+ * in its ELF header flags.
+ */
+#ifdef CONFIG_MIPS_O32_FP64_SUPPORT
+# define __MIPS_O32_FP64_MUST_BE_ZERO	0
+#else
+# define __MIPS_O32_FP64_MUST_BE_ZERO	EF_MIPS_FP64
+#endif
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x)	elf_check_arch_32(x)
+
 /*
  * These are used to set parameters in the core dumps.
  */
@@ -253,18 +270,7 @@ struct mips_elf_abiflags_v0 {
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(hdr)						\
-({									\
-	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
-									\
-	if (__h->e_machine != EM_MIPS)					\
-		__res = 0;						\
-	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
-		__res = 0;						\
-									\
-	__res;								\
-})
+#define elf_check_arch(x)	elf_check_arch_64(x)
 
 /*
  * These are used to set parameters in the core dumps.
-- 
2.5.0
