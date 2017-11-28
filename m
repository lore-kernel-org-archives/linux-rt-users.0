From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 03/10] random: avoid preempt_disable()ed section
Date: Mon, 27 Nov 2017 21:18:53 -0500
Message-ID: <20171127211853.0fb09380@vmware.local.home>
References: <20171123053341.174002403@goodmis.org>
        <20171123053433.594374450@goodmis.org>
        <584fdcad-9afe-fb19-04dd-46358a04fc17@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: Alex Shi <alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <584fdcad-9afe-fb19-04dd-46358a04fc17@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 24 Nov 2017 14:26:40 +0800
Alex Shi <alex.shi@linaro.org> wrote:

> Hi Steve,
> 
> I just build the patches, a build error found here:
> 
> drivers/char/random.c: In function ‘get_random_int’:
> drivers/char/random.c:1816:7: error: assignment from incompatible
> pointer type [-Werror=incompatible-pointer-types]
>   hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
>        ^
> drivers/char/random.c: In function ‘get_random_long’:
> drivers/char/random.c:1838:7: error: assignment from incompatible
> pointer type [-Werror=incompatible-pointer-types]
>   hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
>        ^
> 
> > -	hash = get_cpu_var(get_random_int_hash);
> > +	hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);  
>                ^
> Is this a extra '&' which need to remove?
> 
> >  
> >  	hash[0] += current->pid + jiffies + random_get_entropy();
> >  	md5_transform(hash, random_int_secret);
> >  	ret = hash[0];
> > -	put_cpu_var(get_random_int_hash);
> > +	put_locked_var(hash_entropy_int_lock, get_random_int_hash);
> >  
> >  	return ret;
> >  }
> > @@ -1833,12 +1835,12 @@ unsigned long get_random_long(void)
> >  	if (arch_get_random_long(&ret))
> >  		return ret;
> >  
> > -	hash = get_cpu_var(get_random_int_hash);
> > +	hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);  
>                ^
> Ditto

Thanks! I made the following update. I forgot to check for warnings in
the build. :-/

-- Steve

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b41745c5962c..46c0e27cf27f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1813,7 +1813,7 @@ unsigned int get_random_int(void)
 	if (arch_get_random_int(&ret))
 		return ret;
 
-	hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
+	hash = get_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	hash[0] += current->pid + jiffies + random_get_entropy();
 	md5_transform(hash, random_int_secret);
@@ -1835,7 +1835,7 @@ unsigned long get_random_long(void)
 	if (arch_get_random_long(&ret))
 		return ret;
 
-	hash = &get_locked_var(hash_entropy_int_lock, get_random_int_hash);
+	hash = get_locked_var(hash_entropy_int_lock, get_random_int_hash);
 
 	hash[0] += current->pid + jiffies + random_get_entropy();
 	md5_transform(hash, random_int_secret);
