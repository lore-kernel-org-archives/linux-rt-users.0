Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EAD16D9C3
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956676; cv=none; b=LYEBse8ghsubU1leKYaxC8c7bJhTpudKx2YdeacGekEyC9laYckaIKKNxWpPBJj1Xzd4Fe45Tq5w7FJ1y+8D2PQHkY03gHnWp+z2C0mW0YGYHbrlL74CVs84dhhDp7i3gQz1PU85lVjxziYoNsxa0lSbEjEuQ9pPKFHT76cHRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956676; c=relaxed/simple;
	bh=C+qp9GPyHh1N2C2oYj2p5PCzaBss2KIjhII2WxLRLcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+gIqIdfhG1YJG9ahuYEfOlHvQdUB4/sx0WWnUam71NXBQU62aNOUMZjISsp4ICbkovRYP+RzQ6Z2q6igJI0kf9Fs/vtJPi21ZlVEbhv8Kcq5F3hmNs6qy5YjvEsHfUZs3fWPCmWnCj4F6qe3drjTR6vy5XsmFs8NxBROf5KlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SHKdsebm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SHKdsebm"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec3c0dada3so21627531fa.0
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 00:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718956672; x=1719561472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhsKIUpVs1TdSA54MS8smHb/osJ9XEePDMz6uc60+M4=;
        b=SHKdsebmDqPeSKdTZYXEc03ijG56SHulAvXL3YkZ5iyc+lOJdabilz9vbS05JwAl1i
         tdm/wrLly19zYULdJQa28XfHWzK4KEpu2+F63hyhccKtjcOrTMmty6mECVibktWb6lAQ
         EzBGBIQB7oHQFqrRNn91pyJhZ5YgRGuRwUUechh3vwOTuB0bvz+IeJCVUXfOnpi84Be4
         IJeArdMpW5uNYDqVFVtbY5rKm36YkLEJmcccfDCuRNTprHueA8MSLgVa0/MiHOkaeQPq
         YvkRPwkrg4taQwQklhLtNxDO+w8R8ewac9dRfMUUD8uE6fWqnsarl1ftOXtXwp2DNNBY
         2PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718956672; x=1719561472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhsKIUpVs1TdSA54MS8smHb/osJ9XEePDMz6uc60+M4=;
        b=Pmryjy+y4KKUHNuuDSd0M2Zrjxr3ORXekuEFDuI92MmxG/2ebUzlFV7ZU4/lV0dJ34
         vb2XegZTQXrMy2/tKSpsMZyygJCSO6muSQroeMS2IvEhm8Sif6Ufl3IvrxyVMSwIWxFR
         BqhSBVUAVr7lXI+n7X9BRjiruPX3FRALFMhj3Z98M/vaspCZqEc3T9ddM+1v8Ob4Jrk7
         /NI/f7B/xl5Dk7ZOsDHqh0oeHLAZzpS9+kfMJC/+z1qJnvg3giBtz3gdbX1cgWcAZ7KW
         BL4sPztMoJAJNlN6KmRUf3URrExiqHG+j7qUsiAvTtfWYmB+W1osT070sKoasTM2Yd9F
         /WoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfgfHKELsJlT7J6avV2juYIs6tJ7NQ4fm709FJ9YSlPsbwq8woHoOWXHki8q687gnAQVsgF4/c1CxMWyhtb4OCbCq1u3uNXx+eW4TrmR8=
X-Gm-Message-State: AOJu0Yz4J0YEl/pBe2pZ8eeMLW94OUcpxXdRDLEG20uITCD8B6mHGTGy
	b9FuwSMaiFpS88QyraJvcYUWeIaQRFGn11Qt39H72y8l5sLsjOAWHHULQJzOpUU=
X-Google-Smtp-Source: AGHT+IEGvQBKmN8D7BaAeOSyvISpb51HpJPvTwb871KJrb0o6vN4Rdh//iJ0n4JpwTkO40g8tJemcA==
X-Received: by 2002:a2e:99ca:0:b0:2ec:1d30:7303 with SMTP id 38308e7fff4ca-2ec3cfe0ccdmr50952631fa.51.1718956672410;
        Fri, 21 Jun 2024 00:57:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511b053dsm811824b3a.85.2024.06.21.00.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:57:51 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:57:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, williams@redhat.com,
	jlelli@redhat.com, lgoncalv@redhat.com, jwyatt@redhat.com,
	aubaker@redhat.com
Subject: Re: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck for
 78s
Message-ID: <ZnUydTAC9lbTvF9H@pathway.suse.cz>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <87msni13lv.fsf@jogness.linutronix.de>
 <dtde47mfm3amxg4mbrnbct53ehpfbekdvrjhhd6j5tzl7lulwj@zwdsvkq3orag>
 <ZnKo_n9LJnMCPSCA@pathway.suse.cz>
 <xt5rhuygy2wwugsbdxemfrlkfcj6czfsmdkkjlqpmf4lcvc4pk@o6j6errohzfs>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xt5rhuygy2wwugsbdxemfrlkfcj6czfsmdkkjlqpmf4lcvc4pk@o6j6errohzfs>

On Thu 2024-06-20 12:27:12, Andrew Halaney wrote:
> On Wed, Jun 19, 2024 at 11:46:38AM GMT, Petr Mladek wrote:
> > On Tue 2024-06-18 17:52:19, Andrew Halaney wrote:
> > > On Tue, Jun 18, 2024 at 09:03:00PM GMT, John Ogness wrote:
> > > Just in case I did something dumb, here's the module I wrote up:
> > > 
> > > ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % cat kernel/printk/test_thread.c                         :(
> > > /*
> > >  * Test making a kthread similar to nbcon's (under load)
> > >  * to see if it also has issues with migrate_swap()
> > >  */
> > > #include "linux/nmi.h"
> > > #include <asm-generic/delay.h>
> > > #include <linux/kthread.h>
> > > #include <linux/module.h>
> > > #include <linux/sched.h>
> > > 
> > > DEFINE_STATIC_SRCU(test_srcu);
> > > static DEFINE_SPINLOCK(test_lock);
> > > static struct task_struct *kt;
> > > static bool dont_stop = true;
> > > 
> > > static int test_thread_func(void *unused) {
> > > 	unsigned long flags;
> > > 
> > > 	pr_info("Starting the while true loop\n");
> > > 	do {
> > > 		int cookie = srcu_read_lock_nmisafe(&test_srcu);
> > > 		spin_lock_irqsave(&test_lock, flags);
> > > 		touch_nmi_watchdog();
> > > 		udelay(5000);  // print a line to serial
> > > 		spin_unlock_irqrestore(&test_lock, flags);
> > > 		srcu_read_unlock_nmisafe(&test_srcu, cookie);
> > 
> > Does it help to add here?
> > 
> > 		cond_resched();
> > 
> > > 	} while (dont_stop);
> > > 
> > > 	return 0;
> > > }
> > > 
> > > static int __init test_thread_init(void) {
> > > 
> > > 	pr_info("Creating test_thread at -20 nice level\n");
> > > 	kt = kthread_run(test_thread_func, NULL, "test_thread");
> > > 	if (IS_ERR(kt)) {
> > > 		pr_err("Failed to make test_thread\n");
> > > 		return PTR_ERR(kt);
> > > 	}
> > > 	sched_set_normal(kt, -20);
> > > 
> > > 	return 0;
> > > }
> > > 
> > > static void __exit test_thread_exit(void) {
> > > 	dont_stop = false;
> > > 	kthread_stop(kt);
> > > }
> > > 
> > > module_init(test_thread_init);
> > > module_exit(test_thread_exit);
> > > MODULE_LICENSE("GPL");
> > 
> > The touch_nmi_watchdog() caused that watchdog_timer_fn() did not see
> > that "test_thread" kthread did not schedule. By other words, it did
> > hide the problem.
> > 
> 
> Is it reasonable to consider removing the touch_nmi_watchdog()'s in
> 8250_port.c? There's some rather old ones, and some new ones with the
> nbcon transition, and they sort of made finding this issue more
> indirect.
> 
> Could be some valid reason they exist still, but to me it seems sensible
> to remove if we can't think of any good reasons.

Good point!

I believe that they were added because of flushing printk() messages.

This is the case of commit 54f19b4a6791491 ("tty/serial/8250: Touch
NMI watchdog in  wait_for_xmitr"), definitely. The others were added
before git history so that it is more complicated to check it.

Anyway, I think that it is not necessary to touch the watchdog on
every operation on the serial console. It should be enough to
touch them only around writing single printk record/message.
And it is better to do so in the generic printk cycle than
in particular console drivers.

Well, we need to make sure that the watchdog is touched in all
cycles flushing consoles, like console_flush_all() or
__nbcon_atomic_flush_pending_con().

Best Regards,
Petr
