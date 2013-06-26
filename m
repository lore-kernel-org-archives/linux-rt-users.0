From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-next v2] kvm: don't try to take mmu_lock while holding
 the main raw kvm_lock
Date: Wed, 26 Jun 2013 23:59:40 +0200
Message-ID: <51CB644C.1090305@redhat.com>
References: <51CAA1DE.2020307@redhat.com> <1372270295-16496-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kvm@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Gleb Natapov <gleb@redhat.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:59786 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3FZV7s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 17:59:48 -0400
In-Reply-To: <1372270295-16496-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 26/06/2013 20:11, Paul Gortmaker ha scritto:
>  		spin_unlock(&kvm->mmu_lock);
> +		kvm_put_kvm(kvm);
>  		srcu_read_unlock(&kvm->srcu, idx);
>  

kvm_put_kvm needs to go last.  I can fix when applying, but I'll wait
for Gleb to take a look too.

Paolo
