Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:52576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732493AbeGLBP4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Jul 2018 21:15:56 -0400
Date: Wed, 11 Jul 2018 21:08:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [rfc 4.16-rt patch] arm64: efi,fpsimd: use a local_lock() in
 efi_virtmap_load()
Message-ID: <20180711210855.53f31874@vmware.local.home>
In-Reply-To: <1531321642.12761.30.camel@gmx.de>
References: <1531321642.12761.30.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 11 Jul 2018 17:07:22 +0200
Mike Galbraith <efault@gmx.de> wrote:

> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -607,8 +607,8 @@ int sve_set_vector_length(struct task_st
>  		sve_to_fpsimd(task);
>  
>  	if (task == current) {
> -		local_unlock(fpsimd_lock);
>  		local_bh_enable();
> +		local_unlock(fpsimd_lock);
>  	}
>  
>  	/*
> @@ -841,8 +841,8 @@ asmlinkage void do_sve_acc(unsigned int
>  
>  	sve_alloc(current);
>  
> -	local_bh_disable();
>  	local_lock(fpsimd_lock);
> +	local_bh_disable();
>  
>  	task_fpsimd_save();
>  	fpsimd_to_sve(current);
> @@ -854,8 +854,8 @@ asmlinkage void do_sve_acc(unsigned int
>  	if (test_and_set_thread_flag(TIF_SVE))
>  		WARN_ON(1); /* SVE access shouldn't have trapped */
>  
> -	local_unlock(fpsimd_lock);
>  	local_bh_enable();
> +	local_unlock(fpsimd_lock);
>  }
>  

We really need to have a local_lock_bh(...)

-- Steve
