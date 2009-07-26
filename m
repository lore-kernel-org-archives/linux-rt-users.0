From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sun, 26 Jul 2009 16:04:08 +0530
Message-ID: <921ca19c0907260334n796cbcecja2a837c0da8f7133@mail.gmail.com>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com>
	 <4A6981B0.3000008@siemens.com> <4A6B1C15.6090608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Gregory Haskins <gregory.haskins@gmail.com>,
	"Yang, Sheng" <sheng.yang@intel.com>, Avi Kivity <avi@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>,
	kvm-devel <kvm@vger.kernel.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4A6B1C15.6090608@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Do not meddle in the internals of kernels, for they are subtle and quick to
> panic.
Also the kvm code. Are you sure that the processor supports KVM
Extension. I know of a lot of intel architectures where KVM is not
support. Especially the HW_CHECK_SUM. Might not be sure, but this sure
seems an problem. Also there is no dependency check with the KVM on
Linux. What I mean by this is that KVM Install on an Architecture that
donot support the extension without problem. So compiling KVM alone
does not mean it works on an architecture.


-- 
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
