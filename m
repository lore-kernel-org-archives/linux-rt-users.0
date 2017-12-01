From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Fri, 1 Dec 2017 14:18:28 +0000
Message-ID: <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
References: <20171130142216.GB12606@linutronix.de>
 <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de>
 <20171201134506.GF1612@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201134506.GF1612@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[Adding Ard, who wrote the NEON crypto code]

On Fri, Dec 01, 2017 at 02:45:06PM +0100, Sebastian Andrzej Siewior wrote:
> +arm folks, to let you know
> 
> On 2017-12-01 11:43:32 [+0100], To linux-rt-users@vger.kernel.org wrote:
> > NEON in kernel mode is used by the crypto algorithms and raid6 code.
> > While the raid6 code looks okay, the crypto algorithms do not: NEON
> > is enabled on first invocation and may allocate/free/map memory before
> > the NEON mode is disabled again.

Could you elaborate on why this is a problem?

I guess this is because kernel_neon_{begin,end}() disable preemption?

... is this specific to RT?

Thanks,
Mark.

> > This needs to be changed until it can be enabled.
> > On ARM NEON in kernel mode can be simply disabled. on ARM64 it needs to
> > stay on due to possible EFI callbacks so here I disable each algorithm.
> > 
> > Cc: stable-rt@vger.kernel.org
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  arch/arm/Kconfig                  |  2 +-
> >  arch/arm64/crypto/Kconfig         | 20 ++++++++++----------
> >  arch/arm64/crypto/crc32-ce-glue.c |  3 ++-
> >  3 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index d1346a160760..914fecb088a8 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -2164,7 +2164,7 @@ config NEON
> >  
> >  config KERNEL_MODE_NEON
> >  	bool "Support for NEON in kernel mode"
> > -	depends on NEON && AEABI
> > +	depends on NEON && AEABI && !PREEMPT_RT_BASE
> >  	help
> >  	  Say Y to include support for NEON in kernel mode.
> >  
> > diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> > index 70c517aa4501..2a5f05b5a19a 100644
> > --- a/arch/arm64/crypto/Kconfig
> > +++ b/arch/arm64/crypto/Kconfig
> > @@ -19,19 +19,19 @@ config CRYPTO_SHA512_ARM64
> >  
> >  config CRYPTO_SHA1_ARM64_CE
> >  	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
> > -	depends on KERNEL_MODE_NEON
> > +	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_HASH
> >  	select CRYPTO_SHA1
> >  
> >  config CRYPTO_SHA2_ARM64_CE
> >  	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
> > -	depends on KERNEL_MODE_NEON
> > +	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_HASH
> >  	select CRYPTO_SHA256_ARM64
> >  
> >  config CRYPTO_GHASH_ARM64_CE
> >  	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
> > -	depends on KERNEL_MODE_NEON
> > +	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_HASH
> >  	select CRYPTO_GF128MUL
> >  	select CRYPTO_AES
> > @@ -39,7 +39,7 @@ config CRYPTO_GHASH_ARM64_CE
> >  
> >  config CRYPTO_CRCT10DIF_ARM64_CE
> >  	tristate "CRCT10DIF digest algorithm using PMULL instructions"
> > -	depends on KERNEL_MODE_NEON && CRC_T10DIF
> > +	depends on KERNEL_MODE_NEON && CRC_T10DIF && !PREEMPT_RT_BASE
> >  	select CRYPTO_HASH
> >  
> >  config CRYPTO_CRC32_ARM64_CE
> > @@ -53,13 +53,13 @@ config CRYPTO_AES_ARM64
> >  
> >  config CRYPTO_AES_ARM64_CE
> >  	tristate "AES core cipher using ARMv8 Crypto Extensions"
> > -	depends on ARM64 && KERNEL_MODE_NEON
> > +	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_ALGAPI
> >  	select CRYPTO_AES_ARM64
> >  
> >  config CRYPTO_AES_ARM64_CE_CCM
> >  	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
> > -	depends on ARM64 && KERNEL_MODE_NEON
> > +	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_ALGAPI
> >  	select CRYPTO_AES_ARM64_CE
> >  	select CRYPTO_AES_ARM64
> > @@ -67,7 +67,7 @@ config CRYPTO_AES_ARM64_CE_CCM
> >  
> >  config CRYPTO_AES_ARM64_CE_BLK
> >  	tristate "AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions"
> > -	depends on KERNEL_MODE_NEON
> > +	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_BLKCIPHER
> >  	select CRYPTO_AES_ARM64_CE
> >  	select CRYPTO_AES_ARM64
> > @@ -75,7 +75,7 @@ config CRYPTO_AES_ARM64_CE_BLK
> >  
> >  config CRYPTO_AES_ARM64_NEON_BLK
> >  	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
> > -	depends on KERNEL_MODE_NEON
> > +	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_BLKCIPHER
> >  	select CRYPTO_AES_ARM64
> >  	select CRYPTO_AES
> > @@ -83,13 +83,13 @@ config CRYPTO_AES_ARM64_NEON_BLK
> >  
> >  config CRYPTO_CHACHA20_NEON
> >  	tristate "NEON accelerated ChaCha20 symmetric cipher"
> > -	depends on KERNEL_MODE_NEON
> > +	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_BLKCIPHER
> >  	select CRYPTO_CHACHA20
> >  
> >  config CRYPTO_AES_ARM64_BS
> >  	tristate "AES in ECB/CBC/CTR/XTS modes using bit-sliced NEON algorithm"
> > -	depends on KERNEL_MODE_NEON
> > +	depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
> >  	select CRYPTO_BLKCIPHER
> >  	select CRYPTO_AES_ARM64_NEON_BLK
> >  	select CRYPTO_AES_ARM64
> > diff --git a/arch/arm64/crypto/crc32-ce-glue.c b/arch/arm64/crypto/crc32-ce-glue.c
> > index 624f4137918c..599de95cd86d 100644
> > --- a/arch/arm64/crypto/crc32-ce-glue.c
> > +++ b/arch/arm64/crypto/crc32-ce-glue.c
> > @@ -206,7 +206,8 @@ static struct shash_alg crc32_pmull_algs[] = { {
> >  
> >  static int __init crc32_pmull_mod_init(void)
> >  {
> > -	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && (elf_hwcap & HWCAP_PMULL)) {
> > +	if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> > +	    !IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && (elf_hwcap & HWCAP_PMULL)) {
> >  		crc32_pmull_algs[0].update = crc32_pmull_update;
> >  		crc32_pmull_algs[1].update = crc32c_pmull_update;
> >  
> > -- 
> > 2.15.0
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
