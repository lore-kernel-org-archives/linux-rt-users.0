From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/4] KVM: use simple waitqueue for vcpu->wq
Date: Tue, 20 Oct 2015 16:00:31 +0200
Message-ID: <20151020140031.GG17308@twins.programming.kicks-ass.net>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445326090-1698-3-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 20, 2015 at 09:28:08AM +0200, Daniel Wagner wrote:
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 2280497..f534e15 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2560,10 +2560,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>  {
>  	struct kvm_vcpu *vcpu;
>  	int do_sleep = 1;
> +	DECLARE_SWAITQUEUE(wait);
>  
> -	DEFINE_WAIT(wait);
> -
> -	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
> +	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
>  
>  	/*
>  	 * Check one last time for pending exceptions and ceded state after
> @@ -2577,7 +2576,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>  	}
>  
>  	if (!do_sleep) {
> -		finish_wait(&vc->wq, &wait);
> +		finish_swait(&vc->wq, &wait);
>  		return;
>  	}
>  
> @@ -2585,7 +2584,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>  	trace_kvmppc_vcore_blocked(vc, 0);
>  	spin_unlock(&vc->lock);
>  	schedule();
> -	finish_wait(&vc->wq, &wait);
> +	finish_swait(&vc->wq, &wait);
>  	spin_lock(&vc->lock);
>  	vc->vcore_state = VCORE_INACTIVE;
>  	trace_kvmppc_vcore_blocked(vc, 1);

This one looks buggy, one should _NOT_ assume that your blocking
condition is true after schedule().

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8db1d93..45ab55f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2019,7 +2018,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  	}
>  
>  	for (;;) {
> -		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
> +		prepare_to_swait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
>  
>  		if (kvm_vcpu_check_block(vcpu) < 0)
>  			break;
> @@ -2028,7 +2027,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  		schedule();
>  	}
>  
> -	finish_wait(&vcpu->wq, &wait);
> +	finish_swait(&vcpu->wq, &wait);
>  	cur = ktime_get();
>  
>  out:

Should we not take this opportunity to get rid of these open-coded wait
loops?


Does this work?

---
 arch/powerpc/kvm/book3s_hv.c | 33 +++++++++++++++++----------------
 virt/kvm/kvm_main.c          | 13 ++-----------
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 228049786888..b5b8bcad5105 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2552,18 +2552,10 @@ static void kvmppc_wait_for_exec(struct kvmppc_vcore *vc,
 	finish_wait(&vcpu->arch.cpu_run, &wait);
 }
 
-/*
- * All the vcpus in this vcore are idle, so wait for a decrementer
- * or external interrupt to one of the vcpus.  vc->lock is held.
- */
-static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
+static inline bool kvmppc_vcore_should_sleep(struct kvmppc_vcore *vc)
 {
 	struct kvm_vcpu *vcpu;
-	int do_sleep = 1;
-
-	DEFINE_WAIT(wait);
-
-	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+	bool sleep = true;
 
 	/*
 	 * Check one last time for pending exceptions and ceded state after
@@ -2571,26 +2563,35 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	 */
 	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list) {
 		if (vcpu->arch.pending_exceptions || !vcpu->arch.ceded) {
-			do_sleep = 0;
+			sleep = false;
 			break;
 		}
 	}
 
-	if (!do_sleep) {
-		finish_wait(&vc->wq, &wait);
-		return;
-	}
+	return sleep;
+}
 
+static inline void kvmppc_vcore_schedule(struct kvmppc_vcore *vc)
+{
 	vc->vcore_state = VCORE_SLEEPING;
 	trace_kvmppc_vcore_blocked(vc, 0);
 	spin_unlock(&vc->lock);
 	schedule();
-	finish_wait(&vc->wq, &wait);
 	spin_lock(&vc->lock);
 	vc->vcore_state = VCORE_INACTIVE;
 	trace_kvmppc_vcore_blocked(vc, 1);
 }
 
+/*
+ * All the vcpus in this vcore are idle, so wait for a decrementer
+ * or external interrupt to one of the vcpus.  vc->lock is held.
+ */
+static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
+{
+	___wait_event(vc->wq, !kvmppc_vcore_should_sleep(vc), TASK_IDLE, 0, 0,
+		      kvmppc_vcore_schedule(vc));
+}
+
 static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int n_ceded;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8db1d9361993..488f00d79059 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1996,7 +1996,6 @@ static int kvm_vcpu_check_block(struct kvm_vcpu *vcpu)
 void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	ktime_t start, cur;
-	DEFINE_WAIT(wait);
 	bool waited = false;
 	u64 block_ns;
 
@@ -2018,17 +2017,9 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		} while (single_task_running() && ktime_before(cur, stop));
 	}
 
-	for (;;) {
-		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
+	___wait_event(vcpu->wq, kvm_cpu_check_block(vcpu) < 0, TASK_IDLE, 0, 0,
+			waited = true; schedule());
 
-		if (kvm_vcpu_check_block(vcpu) < 0)
-			break;
-
-		waited = true;
-		schedule();
-	}
-
-	finish_wait(&vcpu->wq, &wait);
 	cur = ktime_get();
 
 out:
