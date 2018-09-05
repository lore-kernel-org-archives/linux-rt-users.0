From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 21/22] Drivers: hv: vmbus: include header for
 get_irq_regs()
Date: Wed, 5 Sep 2018 08:34:55 -0400
Message-ID: <20180905083455.78cd72d3@gandalf.local.home>
References: <20180905122754.443196118@goodmis.org>
        <20180905122837.830614967@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        Bernhard Landauer <oberon@manjaro.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905122837.830614967@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


[ It appears that quilt doesn't use the right mime for the strange
  characters in the change log. I'm replying here as it was bounced
  by the mailing lists ]

On Wed, 05 Sep 2018 08:28:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 4.14.63-rt41-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> [ Upstream commit b9fcc1867cc7921bb8441be327ed58461ed12255 ]
> 
> On !RT the header file get_irq_regs() gets pulled in via other header files. On
> RT it does not and the build fails:
> 
>     drivers/hv/vmbus_drv.c:975 implicit declaration of function âget_irq_regsâ [-Werror=implicit-function-declaration]
>     drivers/hv/hv.c:115 implicit declaration of function âget_irq_regsâ [-Werror=implicit-function-declaration]
> 
> Add the header file for get_irq_regs() in a common header so it used by
> vmbus_drv.c by hv.c for their get_irq_regs() usage.
> 
> Reported-by: Bernhard Landauer <oberon@manjaro.org>
> Reported-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  drivers/hv/hyperv_vmbus.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 49569f8fe038..a3608cd52805 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -30,6 +30,7 @@
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  
>  /*
>   * Timeout for services such as KVP and fcopy.
