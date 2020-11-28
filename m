Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE2C8301A
	for <linux-rt-users@archiver.kernel.org>; Sat, 28 Nov 2020 22:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA435208D5
	for <linux-rt-users@archiver.kernel.org>; Sat, 28 Nov 2020 22:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="w8IDa0O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbgK1VuS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733224AbgK1SM6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 28 Nov 2020 13:12:58 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53CFC02A1AC;
        Sat, 28 Nov 2020 06:36:52 -0800 (PST)
Received: from localhost (home.natalenko.name [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 754B28B191B;
        Sat, 28 Nov 2020 15:36:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1606574211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nY94Bf1zvNvxsTxXir0rYoZCxcIpbT0DlCop8shh+K8=;
        b=w8IDa0O+7s417VQgwMcKM+UmoQBYrW45kyrIEIlBfty6H7Ejcsla17wEn/e+Rmcfh3ejxz
        HXlpE2DbkdPKKgB/c/NTMdKf302crCV9rXx/al45auwK3ZJcFwuG3LMZXDGBk8Vx+eK8tc
        1St4fa1OLwJ+h6ouqF8uXlZI+Wy5KQc=
Date:   Sat, 28 Nov 2020 15:36:51 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc5-rt11
Message-ID: <20201128143651.wjxajv5yrkjv2q4w@spock.localdomain>
References: <20201127165957.eukejthckysmjk76@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127165957.eukejthckysmjk76@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi.

On Fri, Nov 27, 2020 at 05:59:57PM +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.10-rc5-rt11 patch set. 
> 
> Changes since v5.10-rc5-rt10:
> 
>   - The workaround for the IMX clock driver failure has been replaced
>     with a another patch which was proposed upstream.
> 
>   - Tweak the rtmutex patches to build a allnoconfig with RT enabled.
> 
> Known issues
>      - It has been pointed out that due to changes to the printk code the
>        internal buffer representation changed. This is only an issue if tools
>        like `crash' are used to extract the printk buffer from a kernel memory
>        image.
> 
> The delta patch against v5.10-rc5-rt10 is appended below and can be found here:
>  
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc5-rt10-rt11.patch.xz
> 
> You can get this release via the git tree at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc5-rt11

It seems that the v5.10-rc5-rt11 tag was not pushed:

```
$ git fetch rt-devel --tags

$ git tag | grep v5.10-rc5-rt11
v5.10-rc5-rt11-patches
v5.10-rc5-rt11-rebase

$ git tag | grep v5.10-rc5-rt10
v5.10-rc5-rt10
v5.10-rc5-rt10-patches
v5.10-rc5-rt10-rebase
```

> 
> The RT patch against v5.10-rc5 can be found here:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc5-rt11.patch.xz
> 
> The split quilt queue is available at:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc5-rt11.tar.xz
> 
> Sebastian
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 3b393cb072951..dbacdd70af2e1 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -5,7 +5,7 @@ config MXC_CLK
>  	depends on ARCH_MXC || COMPILE_TEST
>  
>  config MXC_CLK_SCU
> -	tristate "IMX SCU clock"
> +	tristate
>  	depends on ARCH_MXC || COMPILE_TEST
>  	depends on IMX_SCU && HAVE_ARM_SMCCC
>  
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index b8bf9460c91d7..dd6a737d060b4 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -26,9 +26,9 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
>  obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
>  obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
>  
> -obj-$(CONFIG_MXC_CLK_SCU)	+= clk-imx-scu.o
> -clk-imx-scu-y			:= clk-scu.o clk-lpcg-scu.o
> -obj-$(CONFIG_CLK_IMX8QXP)	+= clk-imx8qxp.o clk-imx8qxp-lpcg.o
> +obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
> +clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o
> +clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
>  
>  obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
>  obj-$(CONFIG_CLK_IMX25)  += clk-imx25.o
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
> index 336dce43da82d..1f0e44f921aee 100644
> --- a/drivers/clk/imx/clk-lpcg-scu.c
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -115,4 +115,3 @@ struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
>  
>  	return hw;
>  }
> -EXPORT_SYMBOL_GPL(imx_clk_lpcg_scu);
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 026a33606ae53..b8b2072742a56 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -9,7 +9,6 @@
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> -#include <linux/module.h>
>  
>  #include "clk-scu.h"
>  
> @@ -133,7 +132,6 @@ int imx_clk_scu_init(void)
>  {
>  	return imx_scu_get_handle(&ccm_ipc_handle);
>  }
> -EXPORT_SYMBOL_GPL(imx_clk_scu_init);
>  
>  /*
>   * clk_scu_recalc_rate - Get clock rate for a SCU clock
> @@ -389,5 +387,3 @@ struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents,
>  
>  	return hw;
>  }
> -EXPORT_SYMBOL_GPL(__imx_clk_scu);
> -MODULE_LICENSE("GPL");
> diff --git a/include/linux/spinlock_types_up.h b/include/linux/spinlock_types_up.h
> index b0243ba07fb78..d9b371fa13e09 100644
> --- a/include/linux/spinlock_types_up.h
> +++ b/include/linux/spinlock_types_up.h
> @@ -1,6 +1,10 @@
>  #ifndef __LINUX_SPINLOCK_TYPES_UP_H
>  #define __LINUX_SPINLOCK_TYPES_UP_H
>  
> +#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__LINUX_RT_MUTEX_H)
> +# error "please don't include this file directly"
> +#endif
> +
>  /*
>   * include/linux/spinlock_types_up.h - spinlock type definitions for UP
>   *
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index c1203c14fee92..b5cd1e278eb58 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -65,6 +65,7 @@ config PREEMPT_RT
>  	bool "Fully Preemptible Kernel (Real-Time)"
>  	depends on EXPERT && ARCH_SUPPORTS_RT
>  	select PREEMPTION
> +	select RT_MUTEXES
>  	help
>  	  This option turns the kernel into a real-time kernel by replacing
>  	  various locking primitives (spinlocks, rwlocks, etc.) with
> diff --git a/localversion-rt b/localversion-rt
> index d79dde624aaac..05c35cb580779 100644
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt10
> +-rt11

-- 
  Oleksandr Natalenko (post-factum)
