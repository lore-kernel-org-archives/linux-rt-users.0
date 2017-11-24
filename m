From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH RT 03/10] random: avoid preempt_disable()ed section
Date: Fri, 24 Nov 2017 14:26:40 +0800
Message-ID: <584fdcad-9afe-fb19-04dd-46358a04fc17@linaro.org>
References: <20171123053341.174002403@goodmis.org>
 <20171123053433.594374450@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:42490 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbdKXG0q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Nov 2017 01:26:46 -0500
Received: by mail-io0-f180.google.com with SMTP id u42so28556412ioi.9
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2017 22:26:46 -0800 (PST)
In-Reply-To: <20171123053433.594374450@goodmis.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Steve,

I just build the patches, a build error found here:

drivers/char/random.c: In function ‘get_random_int’:
drivers/char/random.c:1816:7: error: assignment from incompatible
pointer type [-Werror=incompatible-pointer-types]
  hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
       ^
drivers/char/random.c: In function ‘get_random_long’:
drivers/char/random.c:1838:7: error: assignment from incompatible
pointer type [-Werror=incompatible-pointer-types]
  hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
       ^

> -	hash = get_cpu_var(get_random_int_hash);
> +	hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
               ^
Is this a extra '&' which need to remove?

>  
>  	hash[0] += current->pid + jiffies + random_get_entropy();
>  	md5_transform(hash, random_int_secret);
>  	ret = hash[0];
> -	put_cpu_var(get_random_int_hash);
> +	put_locked_var(hash_entropy_int_lock, get_random_int_hash);
>  
>  	return ret;
>  }
> @@ -1833,12 +1835,12 @@ unsigned long get_random_long(void)
>  	if (arch_get_random_long(&ret))
>  		return ret;
>  
> -	hash = get_cpu_var(get_random_int_hash);
> +	hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
               ^
Ditto

Regards
Alex
