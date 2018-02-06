From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v4.14.15-rt13
Date: Tue, 6 Feb 2018 14:38:43 -0500
Message-ID: <201802061438.43464.gheskett@shentel.net>
References: <20180129223723.lr5avyspmglwcddr@linutronix.de> <201802060907.56549.gheskett@shentel.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda1.shentel.net ([204.111.1.144]:18603 "EHLO
        barracuda4.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754041AbeBFTii (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Feb 2018 14:38:38 -0500
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda4.shentel.net with ESMTP id 0qwahsmpkncfsGLB for <linux-rt-users@vger.kernel.org>; Tue, 06 Feb 2018 14:38:33 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id C361721B8D
        for <linux-rt-users@vger.kernel.org>; Tue,  6 Feb 2018 14:38:33 -0500 (EST)
In-Reply-To: <201802060907.56549.gheskett@shentel.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 06 February 2018 09:07:56 Gene Heskett wrote:

> On Monday 29 January 2018 17:37:23 Sebastian Andrzej Siewior wrote:
> > Dear RT folks!
> >
> > I'm pleased to announce the v4.14.15-rt13 patch set.
> >
> > Changes since v4.14.15-rt12:
> >
> >   - In the previous release the ping-sysrq patch was removed from
> > the queue but has been left listed in the series by mistake. "git
> > quiltimport" simply ignored that patch while "quilt push -a" did not
> > continue. This release provides a corrected series file. Reported by
> > Salvatore Bonaccorso.
> >
> > Known issues
> >      - A warning triggered in "rcu_note_context_switch" originated
> > from SyS_timer_gettime(). The issue was always there, it is now
> > visible. Reported by Grygorii Strashko and Daniel Wagner.
> >
> > The delta patch against v4.14.15-rt12 is appended below and can be
> > found here:
> >
> >
> > https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-
> >4. 14.15-rt12-rt13.patch.xz
> >
> > You can get this release via the git tree at:
> >
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> > v4.14.15-rt13
>
> pulled this one. copied rock64 defconfig to top level dir. Read the
> docs, some prerequisites are missing, like sphinx.
>
> But make menuconfig fails:
> scripts/kconfig/Makefile:202: recipe for
> target 'scripts/kconfig/dochecklxdialog' failed
> make[1]: *** [scripts/kconfig/dochecklxdialog] Error 1
>
> Thats probably because something in the Docs/process/changes.rst is
> missing from a stretch install on an arm64 board. And a sudo apt
> install $name can't find it
>
> What am I missing thats available in stretch to satisfy this?
>
Ping?  If this is not the right list for the question, what might the 
right list be called?

> > The RT patch against v4.14.15 can be found here:
> >
> >
> > https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch
> >-4 .14.15-rt13.patch.xz
> >
> > The split quilt queue is available at:
> >
> >
> > https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch
> >es -4.14.15-rt13.tar.xz
> >
> > Sebastian
> >
> > diff --git a/localversion-rt b/localversion-rt
> > index 6e44e540b927..9f7d0bdbffb1 100644
> > --- a/localversion-rt
> > +++ b/localversion-rt
> > @@ -1 +1 @@
> > --rt12
> > +-rt13
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-rt-users" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html



-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
