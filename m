From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH-next] kvm: don't try to take mmu_lock while holding the
 main raw kvm_lock
Date: Thu, 27 Jun 2013 15:32:51 +0300
Message-ID: <20130627123251.GO18508@redhat.com>
References: <1372199643-3936-1-git-send-email-paul.gortmaker@windriver.com>
 <20130627110911.GH18508@redhat.com>
 <51CC2435.7080204@redhat.com>
 <51CC2D07.8080105@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, mtosatti@redhat.com
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab3F0Mc5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Jun 2013 08:32:57 -0400
Content-Disposition: inline
In-Reply-To: <51CC2D07.8080105@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jun 27, 2013 at 02:16:07PM +0200, Jan Kiszka wrote:
> On 2013-06-27 13:38, Paolo Bonzini wrote:
> > Il 27/06/2013 13:09, Gleb Natapov ha scritto:
> >> On Tue, Jun 25, 2013 at 06:34:03PM -0400, Paul Gortmaker wrote:
> >>> In commit e935b8372cf8 ("KVM: Convert kvm_lock to raw_spinlock"),
> >> I am copying Jan, the author of the patch. Commit message says:
> >> "Code under this lock requires non-preemptibility", but which code
> >> exactly is this? Is this still true?
> > 
> > hardware_enable_nolock/hardware_disable_nolock does.
> 
> IIRC, also the loop in kvmclock_cpufreq_notifier needs it because it
> reads the processor ID of the caller. That implies the caller cannot be
> preempted, but theses days a migration lock should be fine as well.
> 
OK, adding Marcelo to the party. This code is called from cpufreq
notifier. I would expect that it will be called from the context that
prevents migration to another cpu.

--
			Gleb.
