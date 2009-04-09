From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 3/3] kvm: wake up waitqueue before calling get_cpu()
Date: Thu, 9 Apr 2009 06:24:30 -0300
Message-ID: <20090409092430.GB30211@amt.cnet>
References: <20090407235853.309888494@suse.de> <20090407235902.542493610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rt-users <linux-rt-users@vger.kernel.org>, kvm@vger.kernel.org
To: Jan Blunck <jblunck@suse.de>
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090407235902.542493610@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Acked-by: Marcelo Tosatti <mtosatti@redhat.com>

On Wed, Apr 08, 2009 at 01:58:56AM +0200, Jan Blunck wrote:
> This moves the get_cpu() call down to be called after we wake up the
> waiters. Therefore the waitqueue locks can savely be rt mutex.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
> Signed-off-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
> ---
>  arch/x86/kvm/x86.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: b/arch/x86/kvm/x86.c
> ===================================================================
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4229,7 +4229,7 @@ static void vcpu_kick_intr(void *info)
>  void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
>  {
>  	int ipi_pcpu = vcpu->cpu;
> -	int cpu = get_cpu();
> +	int cpu;
>  
>  	if (waitqueue_active(&vcpu->wq)) {
>  		wake_up_interruptible(&vcpu->wq);
> @@ -4239,6 +4239,7 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu
>  	 * We may be called synchronously with irqs disabled in guest mode,
>  	 * So need not to call smp_call_function_single() in that case.
>  	 */
> +	cpu = get_cpu();
>  	if (vcpu->guest_mode && vcpu->cpu != cpu)
>  		smp_call_function_single(ipi_pcpu, vcpu_kick_intr, vcpu, 0);
>  	put_cpu();
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
