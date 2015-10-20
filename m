From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Tue, 20 Oct 2015 15:11:31 +0200
Message-ID: <56263D83.1030709@redhat.com>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbbJTNLj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Oct 2015 09:11:39 -0400
In-Reply-To: <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 20/10/2015 09:28, Daniel Wagner wrote:
> 	min              max          mean            std
> count   382.000000       382.000000    382.000000     382.000000
> mean   6068.552356    269502.528796   8056.016198    3912.128273
> std     707.404966    848866.474783   1062.472704    9835.891707
> min    2335.000000     29828.000000   7337.426000     445.738750
> 25%    6004.500000     44237.500000   7471.094250    1078.834837
> 50%    6372.000000     64175.000000   7663.133700    1783.172446
> 75%    6465.500000    150384.500000   8210.771900    2759.734524
> max    6886.000000  10188451.000000  15466.434000  120469.205668
> 
> After
> 	min             max          mean           std
> count   300.000000      300.000000    300.000000    300.000000
> mean   5618.380000   217464.786667   7745.545114   3258.483272
> std     824.719741   516371.888369    847.391685   5632.943904
> min    3494.000000    31410.000000   7083.574800    438.445477
> 25%    4937.000000    45446.000000   7214.102850   1045.536261
> 50%    6118.000000    67023.000000   7417.330800   1699.574075
> 75%    6224.000000   134191.500000   7871.625600   2809.536185
> max    6654.000000  4570896.000000  13528.788600  52206.226799

Anything above ~10000 cycles means that the host went to C1 or
lower---the number means more or less nothing in that case.

The mean shows an improvement indeed.

Paolo
