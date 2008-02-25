From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [(RT RFC) PATCH v2 2/9] sysctl for runtime-control of lateral
	mutex stealing
Date: Tue, 26 Feb 2008 00:00:11 +0100
Message-ID: <20080225230011.GQ2659@elf.ucw.cz>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net> <20080225160048.11268.55059.stgit@novell1.haskins.net> <20080225215335.GE2659@elf.ucw.cz> <1203980231.16711.115.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, acme@redhat.com, gregkh@suse.de,
	pmorreale@novell.com, mkohari@novell.com
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762327AbYBYXAF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1203980231.16711.115.camel@sven.thebigcorporation.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi!

> > > index c913d48..c24c53d 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -175,6 +175,10 @@ extern struct ctl_table inotify_table[];
> > >  int sysctl_legacy_va_layout;
> > >  #endif
> > >  
> > > +#ifdef CONFIG_RTLOCK_LATERAL_STEAL
> > > +extern int rtmutex_lateral_steal;
> > > +#endif
> > > +
> > 
> > Try checkpatch.
> 
> I have that as part of quilt refresh, and it returns:
> 
> Your patch has no obvious style problems and is ready for
> submission.

Sorry. Anyway, there should not be externs in .c files, so 

extern int rtmutex_lateral_steal;

should go to header file.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
