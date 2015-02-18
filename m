From: Josh Cartwright <joshc@ni.com>
Subject: Re: __HAVE_ARCH_CMPXCHG on ARM?
Date: Wed, 18 Feb 2015 10:34:12 -0600
Message-ID: <20150218163412.GA23160@jcartwri.amer.corp.natinst.com>
References: <20150129185618.GA31459@nathan3500-linux-VM>
 <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
 <20150202133933.GD31847@arm.com>
 <20150203192730.GA10759@jcartwri.amer.corp.natinst.com>
 <20150218104459.GD28763@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Will Deacon <will.deacon@arm.com>,
	Yong Zhang <yong.zhang0@gmail.com>,
	Yong Zhang <yong.zhang@windriver.com>,
	Nathan Sullivan <nathan.sullivan@ni.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:49797 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751596AbbBRQet (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 11:34:49 -0500
In-Reply-To: <20150218104459.GD28763@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 18, 2015 at 11:44:59AM +0100, Sebastian Andrzej Siewior wrote:
> * Josh Cartwright | 2015-02-03 13:27:30 [-0600]:
> 
> >                 native         native
> >                cmpxchg (UP)   cmpxchg (SMP)    __HAVE_ARCH_CMPXCHG
> >         xtensa     X               X
> 
> This one does not always have cmpxchg on UP (only the SMP variant which
> provides atomic operation).

Ah!  Thanks for double checking my work; my eyes started to glaze over
after looking at the other 29 architectures.

  Josh
