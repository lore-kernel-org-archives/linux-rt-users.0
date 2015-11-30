From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v5 2/5] kbuild: Add option to turn incompatible pointer check into error
Date: Mon, 30 Nov 2015 14:38:28 +0100
Message-ID: <1448890711-5812-3-git-send-email-daniel.wagner@bmw-carit.de>
References: <1448890711-5812-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kbuild@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448890711-5812-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

With the introduction of the simple wait API we have two very
similar APIs in the kernel. For example wake_up() and swake_up()
is only one character away. Although the compiler will warn
happily the wrong usage it keeps on going an even links the kernel.
Thomas and Peter would rather like to see early missuses reported
as error early on.

In a first attempt we tried to wrap all swait and wait calls
into a macro which has an compile time type assertion. The result
was pretty ugly and wasn't able to catch all wrong usages.
woken_wake_function(), autoremove_wake_function() and wake_bit_function()
are assigned as function pointers. Wrapping them with a macro around is
not possible. Prefixing them with '_' was also not a real option
because there some users in the kernel which do use them as well.
All in all this attempt looked to intrusive and too ugly.

An alternative is to turn the pointer type check into an error which
catches wrong type uses. Obviously not only the swait/wait ones. That
isn't a bad thing either. Though for the beginning let's introduce it
as options in the kernel hacking section.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 Makefile          | 4 ++++
 lib/Kconfig.debug | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index 416660d..8817273 100644
--- a/Makefile
+++ b/Makefile
@@ -625,6 +625,10 @@ KBUILD_CFLAGS += $(call cc-option,-fno-reorder-blocks,) \
                  $(call cc-option,-fno-partial-inlining)
 endif
 
+ifdef CONFIG_ENABLE_ERR_TYPE_CHECK
+KBUILD_CFLAGS += $(call cc-option,-Werror=incompatible-pointer-types)
+endif
+
 ifneq ($(CONFIG_FRAME_WARN),0)
 KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
 endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ab76b99..21c0193 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -194,6 +194,13 @@ config ENABLE_MUST_CHECK
 	  suppress the "warning: ignoring return value of 'foo', declared with
 	  attribute warn_unused_result" messages.
 
+config ENABLE_ERR_TYPE_CHECK
+       bool "Turn pointer type check into an error"
+       default n
+       help
+         Instead of just warning that a wrong pointer type is used,
+	 bail with a proper compile error.
+
 config FRAME_WARN
 	int "Warn for stack frames larger than (needs gcc 4.4)"
 	range 0 8192
-- 
2.4.3
