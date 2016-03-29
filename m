From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH -rt] kvm,rt: change async pagefault code locking for
 rt-preempt
Date: Tue, 29 Mar 2016 18:33:42 +0200
Message-ID: <20160329163342.GG13334@linutronix.de>
References: <20160318142052.0605524d@annuminas.surriel.com>
 <20160329161346.GE13334@linutronix.de>
 <1459268329.6219.8.camel@redhat.com>
 <56FAAD3B.2050606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rik van Riel <riel@redhat.com>, linux-rt-users@vger.kernel.org,
	williams@redhat.com, srostedt@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33296 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbcC2Qdt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 12:33:49 -0400
Content-Disposition: inline
In-Reply-To: <56FAAD3B.2050606@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paolo Bonzini | 2016-03-29 18:28:43 [+0200]:

>> I missed that swait went upstream, but I believe Paulo fixed
>> up the patch and has it in the KVM tree already.
>
>Yes, I did.  You'll get Rik's patch for free from Linus's tree. :)

great. I just picked it from his tree.

>Paolo

Sebastian
