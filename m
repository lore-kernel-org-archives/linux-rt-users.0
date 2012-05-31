From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] ARM: cmpxchg: define __HAVE_ARCH_CMPXCHG for armv6
 and later
Date: Thu, 31 May 2012 02:24:50 +0100
Message-ID: <20120531012450.GA8506@mudshark.cambridge.arm.com>
References: <1338364287-11614-1-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 Nicolas Pitre <nico@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1338364287-11614-1-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

On Wed, May 30, 2012 at 08:51:26AM +0100, Yong Zhang wrote:
> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> index 7eb18c1..a91b44e 100644
> --- a/arch/arm/include/asm/cmpxchg.h
> +++ b/arch/arm/include/asm/cmpxchg.h
> @@ -127,6 +127,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>  
>  #else	/* min ARCH >= ARMv6 */
>  
> +#define __HAVE_ARCH_CMPXCHG 1
> +
>  extern void __bad_cmpxchg(volatile void *ptr, int size);

As long as this only requires 4-byte cmpxchg support then I think this is
fine. It looks like that's currently the case, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
