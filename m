From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: PowerPC G4
Date: Wed, 05 Sep 2007 09:02:01 +0200
Message-ID: <1188975721.5094.1.camel@godzilla.tecnorama.it>
References: <1188891587.10407.6.camel@godzilla.tecnorama.it>
	 <1188916760.3224.4.camel@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:58704 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755269AbXIEHCG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2007 03:02:06 -0400
In-Reply-To: <1188916760.3224.4.camel@dhcp193.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Daniel,

On Tue, 2007-09-04 at 07:39 -0700, Daniel Walker wrote:
> On Tue, 2007-09-04 at 09:39 +0200, Alessio Igor Bogani wrote:
> > Hi,
> 
> > [   37.440390] Call Trace:
> > [   37.440393] [c1aafc70] [c000864c] show_stack+0x3c/0x194 (unreliable)
> > [   37.440408] [c1aafca0] [c002d2c8] __schedule_bug+0x38/0x48
> > [   37.440418] [c1aafcb0] [c0266690] __schedule+0x3d8/0x47c
> > [   37.440425] [c1aafce0] [c02669f8] schedule+0x54/0xf0
> > [   37.440430] [c1aafcf0] [c0267c74] rt_spin_lock_slowlock+0xfc/0x224
> > [   37.440437] [c1aafd50] [c007b130] lru_cache_add_active+0x20/0xa0
> > [   37.440444] [c1aafd60] [c0080edc] do_wp_page+0x34c/0xdfc
> > [   37.440451] [c1aafda0] [c00855b0] __handle_mm_fault+0x9e8/0xc9c
> > [   37.440458] [c1aafe10] [c02695f4] do_page_fault+0x1e0/0x56c
> > [   37.440465] [c1aaff40] [c00130f4] handle_page_fault+0xc/0x80
> > [   37.440476] --- Exception: 301 at 0x10004888
> > [   37.440483]     LR = 0x10005468
> 
> This is from CONFIG_HIGHMEM .. It's not been ported for -rt properly
> yet .. I would recommend turning it off for now.

You are right.

Thank you very much.

Ciao,
Alessio
