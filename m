From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-next] kvm: don't try to take mmu_lock while holding the
 main raw kvm_lock
Date: Thu, 27 Jun 2013 13:54:55 +0200
Message-ID: <51CC280F.9040402@redhat.com>
References: <1372199643-3936-1-git-send-email-paul.gortmaker@windriver.com> <20130627110911.GH18508@redhat.com> <51CC2435.7080204@redhat.com> <20130627114302.GK18508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org, kvm@vger.kernel.org,
	Jan Kiszka <jan.kiszka@siemens.com>
To: Gleb Natapov <gleb@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab3F0LzG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Jun 2013 07:55:06 -0400
In-Reply-To: <20130627114302.GK18508@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 27/06/2013 13:43, Gleb Natapov ha scritto:
>>> > > I am copying Jan, the author of the patch. Commit message says:
>>> > > "Code under this lock requires non-preemptibility", but which code
>>> > > exactly is this? Is this still true?
>> > 
>> > hardware_enable_nolock/hardware_disable_nolock does.
>> > 
> I suspected this will be the answer and prepared another question :)
> From a glance kvm_lock is used to protect those just to avoid creating
> separate lock, so why not create raw one to protect them and change
> kvm_lock to non raw again. Admittedly I haven't looked too close into
> this yet.

I was wondering the same, but I think it's fine.  There's just a handful
of uses outside virt/kvm/kvm_main.c.

Paolo
