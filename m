From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] Fix v3.2.37-rt55 build break
Date: Tue, 22 Jan 2013 12:24:37 -0500
Message-ID: <1358875477.21576.53.camel@gandalf.local.home>
References: <alpine.LFD.2.03.1301221804320.14732@tycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.03.1301221804320.14732@tycho>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2013-01-22 at 18:15 +0100, John Kacur wrote:

> The following is my fix applied to the rt-kernel, but it's fine with
> me if you want to do the cherry-pick against the stable kernel,
> and then respin fix-rt-int3-x86_32-3.2-rt.patch

Does this fail on vanilla 3.2.37 as well? If so, we need to push it to
mainline stable, and then wait for it to be included for -rt.

-- Steve
