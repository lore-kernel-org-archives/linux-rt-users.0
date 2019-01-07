From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 10/13] drm/i915: disable tracing on -RT
Date: Mon, 7 Jan 2019 21:10:22 +0100
Message-ID: <20190107201021.bzhewivla36iitbi@linutronix.de>
References: <20190107195252.599921907@goodmis.org>
 <20190107195333.594740538@goodmis.org>
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
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        Luca Abeni <lucabe72@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107195333.594740538@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2019-01-07 14:53:02 [-0500], Steven Rostedt wrote:
> 4.14.87-rt50-rc1 stable review patch.
> If anyone has any objections, please let me know.
there is
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/drm-i915-skip-DRM_I915_LOW_LEVEL_TRACEPOINTS-with-NO.patch?h=linux-4.19.y-rt-patches

to address a build failure with CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS.

I know you are aware of that and that there is/was some discussion about
this gem. I would be happier if we could avoid complex code within a
tracepoint.

Sebastian
