From: Avi Kivity <avi@redhat.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sat, 25 Jul 2009 17:52:05 +0300
Message-ID: <4A6B1C15.6090608@redhat.com>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4A6981B0.3000008@siemens.com>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 07/24/2009 12:41 PM, Jan Kiszka wrote:
> Jan (who is now patching his guest to avoid wbinvd where possible)
>
>    

Is there ever a case where it is required?  What about under a 
hypervisor (i.e. check the hypervisor enabled bit).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

