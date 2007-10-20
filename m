From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH 9/9] RT: Only dirty a cacheline if the priority is actually
 changing
Date: Sat, 20 Oct 2007 04:48:59 +0200
Message-ID: <47196C9B.7090909@tiscali.nl>
References: <20071017184745.11272.10024.stgit@novell1.haskins.net> <20071017185113.11272.50568.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935346AbXJTCtU@vger.kernel.org>
In-Reply-To: <20071017185113.11272.50568.stgit@novell1.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Gregory Haskins wrote:
> We can avoid dirtying a rq related cacheline with a simple check, so why not.
> 
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> ---
> 
>  0 files changed, 0 insertions(+), 0 deletions(-)

I think you wanted a patch here?
