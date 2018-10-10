From: luca abeni <luca.abeni@santannapisa.it>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Wed, 10 Oct 2018 12:34:17 +0200
Message-ID: <20181010123417.26c682ef@luca64>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

On Tue,  9 Oct 2018 11:24:26 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Hi all,
> 
> Proxy Execution (also goes under several other names) isn't a new
> concept, it has been mentioned already in the past to this community
> (both in email discussions and at conferences [1, 2]), but no actual
> implementation that applies to a fairly recent kernel exists as of
> today (of which I'm aware of at least - happy to be proven wrong).
> 
> Very broadly speaking, more info below, proxy execution enables a task
> to run using the context of some other task that is "willing" to
> participate in the mechanism, as this helps both tasks to improve
> performance (w.r.t. the latter task not participating to proxy
> execution).

First of all, thanks to Juri for working on this!

I am looking at the patchset, and I have some questions / comments
(maybe some of my questions are really stupid, I do not know... :)


To begin, I have a very high-level comment about proxy execution: I
believe proxy execution is a very powerful concept, that can be used in
many cases, not only to do inheritance on mutual exclusion (think, for
example, about pipelines of tasks: a task implementing a stage of the
pipeline can act as a proxy for the task implementing the previous
stage).

So, I would propose to make the proxy() function of patch more generic,
and not strictly bound to mutexes. Maybe a task structure can contain a
list of tasks for which the task can act as a proxy, and we can have a
function like "I want to act as a proxy for task T" to be invoked when
a task blocks?



			Luca
