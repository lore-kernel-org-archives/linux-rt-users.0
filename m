From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-next v2] kvm: don't try to take mmu_lock while holding
 the main raw kvm_lock
Date: Thu, 27 Jun 2013 12:22:00 +0200
Message-ID: <51CC1248.1000402@redhat.com>
References: <51CAA1DE.2020307@redhat.com> <1372270295-16496-1-git-send-email-paul.gortmaker@windriver.com> <51CB644C.1090305@redhat.com> <20130627025654.GB3297@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: kvm@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Gleb Natapov <gleb@redhat.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6550 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab3F0KWI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Jun 2013 06:22:08 -0400
In-Reply-To: <20130627025654.GB3297@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 27/06/2013 04:56, Paul Gortmaker ha scritto:
>> Il 26/06/2013 20:11, Paul Gortmaker ha scritto:
>>> > >  		spin_unlock(&kvm->mmu_lock);
>>> > > +		kvm_put_kvm(kvm);
>>> > >  		srcu_read_unlock(&kvm->srcu, idx);
>>> > >  
>> > 
>> > kvm_put_kvm needs to go last.  I can fix when applying, but I'll wait
>> > for Gleb to take a look too.
> I'm curious why you would say that -- since the way I sent it has the
> lock tear down be symmetrical and opposite to the build up - e.g.
> 
>  		idx = srcu_read_lock(&kvm->srcu);
> 
> [...]
> 
> +		kvm_get_kvm(kvm);
> 
> [...]
>  		spin_lock(&kvm->mmu_lock);
>  
> [...]
> 
>  unlock:
>  		spin_unlock(&kvm->mmu_lock);
> +		kvm_put_kvm(kvm);
>  		srcu_read_unlock(&kvm->srcu, idx);
>  
> You'd originally said to put the kvm_get_kvm where it currently is;
> perhaps instead we want the get/put to encompass the whole 
> srcu_read locked section?

The put really needs to be the last thing you do, as the data structure
can be destroyed before it returns.  Where you put kvm_get_kvm doesn't
really matter, since you're protected by the kvm lock.  So, moving the
kvm_get_kvm before would also work---I didn't really mean that
kvm_get_kvm has to be literally just before the raw_spin_unlock.

However, I actually like having the get_kvm right there, because it
makes it explicit that you are using reference counting as a substitute
for holding the lock.  I find it quite idiomatic, and in some sense the
lock/unlock is still symmetric: the kvm_put_kvm goes exactly where you'd
have unlocked the kvm_lock.

Paolo
