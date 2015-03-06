From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch -rt 1/2] KVM: use simple waitqueue for vcpu->wq
Date: Fri, 6 Mar 2015 14:54:45 +0100
Message-ID: <20150306135445.GC10155@linutronix.de>
References: <20150114171251.882318257@redhat.com>
 <20150114171459.593877145@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150114171459.593877145@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Marcelo Tosatti | 2015-01-14 15:12:52 [-0200]:

Against which tree was this prepared? Could please rebase it against
v3.18.7-rt2? Because a I see "fuzz 2", the mips file is gone and
s390 rejects almost every chunk.
And there was that mips chunk Steven noticed.
Patch #2 seems to apply but since it requires #1 I wait for the update.

Sebastian
