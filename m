From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] sched: Do not try to replenish from a non deadline tasks
Date: Tue, 07 Oct 2014 15:20:51 +0200
Message-ID: <5433E8B3.6040708@monom.org>
References: <1411565056-15577-1-git-send-email-daniel.wagner@bmw-carit.de> <5433B5B9.70006@arm.com> <5433D654.2020108@monom.org> <5433D84F.3040003@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@arm.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	"juri.lelli@gmail.com" <juri.lelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5433D84F.3040003@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/07/2014 02:10 PM, Daniel Wagner wrote:
> [   36.689416] pthread_-1555    0d..5 18486408us : sched_stat_sleep: comm=pthread_test pid=1554 delay=143975 [ns]
> [   36.689416] pthread_-1555    0d..5 18486408us : sched_wakeup: comm=pthread_test pid=1554 prio=120 success=1 target_cpu=000
> [   36.689416] pthread_-1555    0d..4 18486420us : sched_pi_setprio: comm=pthread_test pid=1555 oldprio=-1 newprio=-1
> [   36.689416] pthread_-1555    0d..4 18486421us : sched_dequeue_dl_entity: comm=pthread_test pid=1555 flags=0
> [   36.689416] pthread_-1555    0d..4 18486421us : sched_enqueue_dl_entity: comm=pthread_test pid=1555 pi_comm=pthread_test pi_pid=1555 flags=8
> [   36.689416] pthread_-1555    0d..4 18486421us : sched_dequeue_dl_entity: comm=pthread_test pid=1555 flags=0
> [   36.689416] pthread_-1555    0d..4 18486422us : sched_enqueue_dl_entity: comm=pthread_test pid=1555 pi_comm=pthread_test pi_pid=1555 flags=0
> [   36.689416] pthread_-1555    0d.H4 18486539us : sched_enqueue_dl_entity: comm=pthread_test pid=1555 pi_comm=pthread_test pi_pid=1555 flags=8

I noticed that the last two lines are different. Maybe that is yet
another path into enqueue_task_dl().
