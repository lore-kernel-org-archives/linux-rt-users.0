From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v7 1/7] video: Use bool instead int pointer for get_opt_bool() argument
Date: Fri, 29 Jan 2016 15:03:22 +0100
Message-ID: <1454076208-28354-2-git-send-email-daniel.wagner@bmw-carit.de>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-rt-users.vger.kernel.org

As the function name already indicates that get_opt_bool() parses
for a bool. It is not a surprise that compiler is complaining
about it when -Werror=3Dincompatible-pointer-types is used:

drivers/video/fbdev/intelfb/intelfbdrv.c: In function =E2=80=98intelfb_=
setup=E2=80=99:
drivers/video/fbdev/intelfb/intelfbdrv.c:353:39: error: passing argumen=
t 3 of =E2=80=98get_opt_bool=E2=80=99 from incompatible pointer type [-=
Werror=3Dincompatible-pointer-types]
   if (get_opt_bool(this_opt, "accel", &accel))

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/f=
bdev/intelfb/intelfbdrv.c
index bbec737..bf20744 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -302,7 +302,7 @@ static __inline__ int get_opt_int(const char *this_=
opt, const char *name,
 }
=20
 static __inline__ int get_opt_bool(const char *this_opt, const char *n=
ame,
-				   int *ret)
+				   bool *ret)
 {
 	if (!ret)
 		return 0;
--=20
2.5.0
