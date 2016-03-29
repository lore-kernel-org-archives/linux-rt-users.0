From: Josh Cartwright <joshc@ni.com>
Subject: Re: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Tue, 29 Mar 2016 18:14:34 -0500
Message-ID: <20160329231434.GO28102@jcartwri.amer.corp.natinst.com>
References: <20160314210058.GE29798@uudg.org>
 <alpine.DEB.2.11.1603190933150.3978@nanos>
 <20160321144016.GA31276@jcartwri.amer.corp.natinst.com>
 <20160329150444.GD13334@linutronix.de>
 <20160329182002.GN28102@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:44215 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757893AbcC2XOo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 19:14:44 -0400
In-Reply-To: <20160329182002.GN28102@jcartwri.amer.corp.natinst.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 29, 2016 at 01:20:02PM -0500, Josh Cartwright wrote:
> On Tue, Mar 29, 2016 at 05:04:44PM +0200, Sebastian Andrzej Siewior wrote:
[..]
> > Looking at the assembly I see:
> > 
> > |ffffffff8121fb41:       48 c7 c2 e0 bb d6 82    mov    $0xffffffff82d6bbe0,%rdx
> > |ffffffff8121fb48:       48 89 df                mov    %rbx,%rdi
> > |ffffffff8121fb4b:       48 c7 c6 30 2b a2 81    mov    $0xffffffff81a22b30,%rsi
> > |ffffffff8121fb52:       e8 a9 0e e9 ff          callq  ffffffff810b0a00 <__raw_spin_lock_init>
> > ???
> > |ffffffff8121fc12:       48 c7 c2 d0 bb d6 82    mov    $0xffffffff82d6bbd0,%rdx
> > |ffffffff8121fc19:       48 c7 c6 7b 2e a3 81    mov    $0xffffffff81a32e7b,%rsi
> > |ffffffff8121fc20:       48 c7 07 00 00 00 00    movq   $0x0,(%rdi)
> > |ffffffff8121fc27:       48 83 c7 08             add    $0x8,%rdi
> > |ffffffff8121fc2b:       e8 d0 0d e9 ff          callq  ffffffff810b0a00 <__raw_spin_lock_init>
> > 
> > rdx holds the third parameter and it is different. What do I miss?
> 
> Hmm.  I'm not sure what's going on here for your build.

Ah!  I think the problem is a bit more nuanced than I let on before.

The problem isn't that _all_ instances of the hlist_bl_head will share a
lockdep class...it's that instances which are INIT_HLIST_BL_HEAD()'d _within
the same compilation unit_ will share a lockdep class.

Depending on what you are looking at, perhaps that's what you're seeing?

  Josh
