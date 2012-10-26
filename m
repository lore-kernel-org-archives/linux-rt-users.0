From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Process Hang in __read_seqcount_begin
Date: Fri, 26 Oct 2012 23:54:28 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210262351330.2756@ionos>
References: <CAN8Q1EdobyFuAvtajGRSqNsCG+XoPA+FkwN=2j_H126mmfEjTQ@mail.gmail.com> <1350925299.8609.978.camel@edumazet-glaptop> <CAN8Q1EeqmHMHD-VUgr7Wzv0Z_DAD1SrEniftg==L14d+hGwu+Q@mail.gmail.com> <CAN8Q1EcTRsHjCJD90q0bKRJFMvi7Vn8YRsyQTAHNtTFVuuNdWQ@mail.gmail.com>
 <CAN8Q1EeB2kC6A_YP9zdtp_qYHMG5FF7-Usjx7Rz5pv--bjhqkQ@mail.gmail.com> <1351053164.6537.95.camel@edumazet-glaptop> <CAN8Q1Ef9sCAG8-KNWXEeuRUcmFNcg93mMG=HRQw6i3UuGtJCVg@mail.gmail.com> <1351270087.30380.9.camel@edumazet-glaptop>
 <CAN8Q1Ed1J-jmO9LppcA=rFXPvxFkk-J9mMb2-NhDYyAQKO2jvQ@mail.gmail.com> <1351285552.30380.20.camel@edumazet-glaptop> <CAN8Q1Ecx-pDR=NBQm4O=VaynQsxBU1wku9e_kcKkWB=xU0OtMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	netfilter@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN8Q1Ecx-pDR=NBQm4O=VaynQsxBU1wku9e_kcKkWB=xU0OtMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 26 Oct 2012, Peter LaDow wrote:
> On Fri, Oct 26, 2012 at 2:05 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> If this were safe, we wouldn't be seeing this lockup and your patch
> wouldn't be needed.  So it seems that your patch doesn't really
> address the issue that we are not "sure a thread cannot be interrupted
> by a softirq, and cannot migrate to another cpu".  Well, we know it
> cannot migrate to another CPU, because there isn't another CPU.  So
> apparently, it can be interrupted by a softirq.  So local_bh_disable
> isn't doing anything useful in the RT patches with regard to this.

RT changes the semantics slightly. And yes it's not prepared for stuff
which is relying on some of the magic mainline implicit semantics.

Let me have a look at the whole scenario, once I'm more awake.

Thanks,

	tglx
