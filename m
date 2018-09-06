From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 00/22] Linux 4.14.63-rt41-rc1
Date: Thu, 6 Sep 2018 09:54:34 +0200
Message-ID: <20180906075434.xa64dy7d6p4yolyi@linutronix.de>
References: <20180905122754.443196118@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180905122754.443196118@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-09-05 08:27:54 [-0400], Steven Rostedt wrote:
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 4.14.63-rt41-rc1.
> 
> Please scream at me if I messed something up. Please test the patches too.
> 
> The -rc release will be uploaded to kernel.org and will be deleted when
> the final release is out. This is just a review release (or release candidate).
> 
> The pre-releases will not be pushed to the git repository, only the
> final release is.
> 
> If all goes well, this patch will be converted to the next main release
> on 9/7/2018.

Your tree (v4.14.63) has
  80d20d35af1ed ("nohz: Fix local_timer_softirq_pending()")
  0a0e0829f9901 ("nohz: Fix missing tick reprogram when interrupting an
                 inline softirq")

which means that the patch "nohz: Prevent erroneous tick stop
invocations" can be reverted / dropped. It might have clashed during the
emerge of the stable tree.

Sebastian
