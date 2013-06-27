From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH-next v2] kvm: don't try to take mmu_lock while holding
 the main raw kvm_lock
Date: Wed, 26 Jun 2013 22:56:54 -0400
Message-ID: <20130627025654.GB3297@windriver.com>
References: <51CAA1DE.2020307@redhat.com>
 <1372270295-16496-1-git-send-email-paul.gortmaker@windriver.com>
 <51CB644C.1090305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <kvm@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	Gleb Natapov <gleb@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:59321 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab3F0C4O (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 22:56:14 -0400
Content-Disposition: inline
In-Reply-To: <51CB644C.1090305@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: [PATCH-next v2] kvm: don't try to take mmu_lock while holding the main raw kvm_lock] On 26/06/2013 (Wed 23:59) Paolo Bonzini wrote:

> Il 26/06/2013 20:11, Paul Gortmaker ha scritto:
> >  		spin_unlock(&kvm->mmu_lock);
> > +		kvm_put_kvm(kvm);
> >  		srcu_read_unlock(&kvm->srcu, idx);
> >  
> 
> kvm_put_kvm needs to go last.  I can fix when applying, but I'll wait
> for Gleb to take a look too.

I'm curious why you would say that -- since the way I sent it has the
lock tear down be symmetrical and opposite to the build up - e.g.

 		idx = srcu_read_lock(&kvm->srcu);

[...]

+		kvm_get_kvm(kvm);

[...]
 		spin_lock(&kvm->mmu_lock);
 
[...]

 unlock:
 		spin_unlock(&kvm->mmu_lock);
+		kvm_put_kvm(kvm);
 		srcu_read_unlock(&kvm->srcu, idx);
 
You'd originally said to put the kvm_get_kvm where it currently is;
perhaps instead we want the get/put to encompass the whole 
srcu_read locked section?

P.
--

> 
> Paolo
