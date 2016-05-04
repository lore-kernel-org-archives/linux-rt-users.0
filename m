From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] cyclictest: stop any tracing after hitting a breaktrace
 threshold
Date: Wed, 4 May 2016 09:20:51 -0400
Message-ID: <20160504092051.54002514@redhat.com>
References: <20160503125953.1987bedd@sluggy.hsv.redhat.com>
	<20160503155644.0aa34c34@redhat.com>
	<20160503152839.4543a973@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160503152839.4543a973@sluggy.hsv.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 3 May 2016 15:28:39 -0500
Clark Williams <williams@redhat.com> wrote:

> The intent is to be able to do something like this:
> 
>     trace-cmd start -e all -p function
>     rteval --duration=12h --cyclictest-breaktrace=150
>     trace-cmd extract

Ah, ok, I get it now. This makes sense.

I think I'd refactor the code opening tracing_on to its own
function so that we avoid the duplicate code in setup_tracer(),
but in any case:

Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>
