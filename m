From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4.1.2-rt1 PATCH] include/linux/pid.h: fix build error
Date: Fri, 15 Jan 2016 16:17:49 +0200
Message-ID: <5698FF8D.2030708@ti.com>
References: <1452867255-1121-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <Grygorii.Strashko@linaro.org>
To: <bigeasy@linutronix.de>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452867255-1121-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sorry- ignore this e-mail pls

On 01/15/2016 04:14 PM, Grygorii Strashko wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>
> This patch fixes build error:
>    CC      kernel/pid_namespace.o
> In file included from kernel/pid_namespace.c:11:0:
> include/linux/pid.h: In function 'get_pid':
> include/linux/pid.h:78:3: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]
>     atomic_inc(&pid->count);
>     ^
> which happens when
>   CONFIG_PROVE_LOCKING=n
>   CONFIG_DEBUG_SPINLOCK=n
>   CONFIG_DEBUG_MUTEXES=n
>   CONFIG_DEBUG_LOCK_ALLOC=n
>
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
>   include/linux/pid.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 23705a53..2cc64b7 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -2,6 +2,7 @@
>   #define _LINUX_PID_H
>
>   #include <linux/rcupdate.h>
> +#include <linux/atomic.h>
>
>   enum pid_type
>   {
>


-- 
regards,
-grygorii
