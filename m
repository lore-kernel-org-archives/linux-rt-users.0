From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] pinctrl: bcm2835: Use raw spinlock for RT compatibility
Date: Wed, 31 Oct 2018 14:49:47 +0100
Message-ID: <CACRpkdaZu7GVy-oHb=aaqswqWCSokkcud=Mz+T-+W_XGiGrEcA@mail.gmail.com>
References: <d71c523a8a0af5628da59a44223a357102c2a193.1540627754.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Tiejun Chen <tiejun.china-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <d71c523a8a0af5628da59a44223a357102c2a193.1540627754.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, Oct 27, 2018 at 10:15 AM Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:

> The BCM2835 pinctrl driver acquires a spinlock in its ->irq_enable,
> ->irq_disable and ->irq_set_type callbacks.  Spinlocks become sleeping
> locks with CONFIG_PREEMPT_RT_FULL=y, therefore invocation of one of the
> callbacks in atomic context may cause a hard lockup if at least two GPIO
> pins in the same bank are used as interrupts.  The issue doesn't occur
> with just a single interrupt pin per bank because the lock is never
> contended.  I'm experiencing such lockups with GPIO 8 and 28 used as
> level-triggered interrupts, i.e. with ->irq_disable being invoked on
> reception of every IRQ.
>
> The critical section protected by the spinlock is very small (one bitop
> and one RMW of an MMIO register), hence converting to a raw spinlock
> seems a better trade-off than converting the driver to threaded IRQ
> handling (which would increase latency to handle an interrupt).
>
> Cc: Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>

Patch applied.

Yours,
Linus Walleij
