From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH tip v6 2/5] kbuild: Add option to turn incompatible
 pointer check into error
Date: Wed, 17 Feb 2016 14:04:51 +0100
Message-ID: <56C46FF3.1000201@bmw-carit.de>
References: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1453992270-4688-3-git-send-email-daniel.wagner@bmw-carit.de>
 <56AB5867.6020405@bmw-carit.de> <20160129185523.GZ8889@windriver.com>
 <56AEFFF1.1010404@bmw-carit.de> <56B45A47.4090400@bmw-carit.de>
 <20160207043916.GR18489@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<linux-kbuild@vger.kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160207043916.GR18489@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/07/2016 05:39 AM, Paul Gortmaker wrote:
>> I used the cross compiler version 5.2.1 shipped by Fedora 23
>> and run allyesconfig/allmodconfig for ARM, ARM64, MIPS64, PPC64
>> (swait-v7 and 4.5-rc2). No new errors popped up.
> 
> SOunds good ; guess my gut feeling about this causing more fallout was
> off the mark.

The fallouts I found are on the way to mainline or are already
in mainline:

fbdev: https://git.kernel.org/tomba/c/206fc20598157ce15597822cf01b94377e30075b
mips:  https://git.kernel.org/torvalds/c/f4d3d504198d464e406171cfa554a59bd4773d79

There was also a hickup on alpha. The patch is on the way. 

Here is the list of archs and config I tried out. First run was with the
config listed, followed by a allyesconfig and allmodconfig build. 

#    name      ARCH     CROSS_COMPILE        config
declare -a config=(
    "alpha     alpha    alpha-linux-gnu-     defconfig"
    "arm32     arm      arm-linux-gnu-       versatile_defconfig"
    "arm64     arm64    aarch64-linux-gnu-   defconfig"
    "cris10    cris     cris-linux-gnu-      etrax-100lx_defconfig"
    "frv       frv      frv-linux-gnu-       defconfig"
    "ia64      ia64     ia64-linux-gnu-      generic_defconfig"
    "m68k      m68k     m68k-linux-gnu-      amiga_defconfig"
    "mips32    mips     mips64-linux-gnu-    ar7_defconfig"
    "mips64    mips     mips64-linux-gnu-    bigsur_defconfig"
    "ppc64     powerpc  powerpc64-linux-gnu- pseries_defconfig"
    "s390      s390     s390x-linux-gnu-     defconfig"
    "sparc32   sparc    sparc64-linux-gnu-   sparc32_defconfig"
    "sparc64   sparc    sparc64-linux-gnu-   sparc64_defconfig"
    "um_x86_64 um       gcc                  defconfig"
    "x86_64    x86_64   gcc                  defconfig"

# known broken configurations on F23
#   "alpha     alpha    alpha-linux-gnu-     allyesconfig"
#   "avr32     avr32    avr32-linux-gnu-     defconfig"
#   "blackfin  blackfin bfin-linux-gnu-      BF518F-EZBRD_defconfig"
#   "cris32    cris     cris-linux-gnu-      etraxfs_defconfig"
#   "m32r      m32r     m32r-linux-gnu-      mappi3.smp_defconfig"
#   "parisc    parisc   hppa-linux-gnu-      default_defconfig"
#   "parisc64  parisc   hppa-linux-gnu-      a500_defconfig"
#   "ppc32     powerpc  powerpc64-linux-gnu- mpc512x_defconfig"
#   "sh32      sh       sh-linux-gnu-        defconfig"
#   "sh64      sh64     sh64-linux-gnu-      defconfig"
#   "tile      tile     tile-linux-gnu-      defconfig"
#   "xtensa    xtensa   xtensa-linux-gnu-    common_defconfig"
)

cheers,
daniel
