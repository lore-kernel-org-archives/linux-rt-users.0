From: Purcareata Bogdan <b43198@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Convert openpic lock to raw_spinlock
Date: Mon, 2 Feb 2015 11:35:40 +0200
Message-ID: <54CF44EC.3050007@freescale.com>
References: <1421919555-11631-1-git-send-email-bogdan.purcareata@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <scottwood@freescale.com>,
	Mihai Caraman <mihai.caraman@freescale.com>,
	<linux-kernel@vger.kernel.org>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421919555-11631-1-git-send-email-bogdan.purcareata@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ping?

On 22.01.2015 11:39, Bogdan Purcareata wrote:
> This patch enables running intensive I/O workloads, e.g. netperf, in a guest
> deployed on a RT host. It also enable guests to be SMP.
>
> The openpic spinlock becomes a sleeping mutex on a RT system. This no longer
> guarantees that EPR is atomic with exception delivery. The guest VCPU thread
> fails due to a BUG_ON(preemptible()) when running netperf.
>
> In order to make the kvmppc_mpic_set_epr() call safe on RT from non-atomic
> context, convert the openpic lock to a raw_spinlock. A similar approach can
> be seen for x86 platforms in the following commit [1].
>
> Here are some comparative cyclitest measurements run inside a high priority RT
> guest run on a RT host. The guest has 1 VCPU and the test has been run for 15
> minutes. The guest runs ~750 hackbench processes as background stress.
>
>                    spinlock  raw_spinlock
> Min latency (us)  4         4
> Avg latency (us)  15        19
> Max latency (us)  70        62
>
> Due to the introduction of the raw_spinlock, guests with a high number of VCPUs
> may induce great latencies on the underlying RT Linux system (e.g. cyclictest
> reports latencies of ~15ms for guests with 24 VCPUs). This can be further
> aggravated by sending a lot of external interrupts to the guest. A malicious app
> can abuse this scenario, causing a DoS of the host Linux. Until the KVM openpic
> code is refactored to use finer lock granularity, impose a limitation on the
> number of VCPUs a guest can have when running on a PREEMPT_RT_FULL system with
> KVM_MPIC emulation.
>
> Sent against v3.14-rt branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
> [1] https://lkml.org/lkml/2010/1/11/289
>
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
> [ add KVM_MAX_VCPUS limitation ]
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Reviewed-by: Scott Wood <scottwood@freescale.com>
> ---
>   arch/powerpc/include/asm/kvm_host.h |  6 +++++
>   arch/powerpc/kvm/mpic.c             | 44 ++++++++++++++++++-------------------
>   2 files changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 1eaea2d..5ae38c5 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -35,8 +35,14 @@
>   #include <asm/page.h>
>   #include <asm/cacheflush.h>
>
> +#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_KVM_MPIC)
> +/* Limit the number of vcpus due to in-kernel mpic concurrency */
> +#define KVM_MAX_VCPUS		4
> +#define KVM_MAX_VCORES		4
> +#else
>   #define KVM_MAX_VCPUS		NR_CPUS
>   #define KVM_MAX_VCORES		NR_CPUS
> +#endif
>   #define KVM_USER_MEM_SLOTS 32
>   #define KVM_MEM_SLOTS_NUM KVM_USER_MEM_SLOTS
>
> diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
> index efbd996..b9802a3 100644
> --- a/arch/powerpc/kvm/mpic.c
> +++ b/arch/powerpc/kvm/mpic.c
> @@ -194,7 +194,7 @@ struct openpic {
>   	int num_mmio_regions;
>
>   	gpa_t reg_base;
> -	spinlock_t lock;
> +	raw_spinlock_t lock;
>
>   	/* Behavior control */
>   	struct fsl_mpic_info *fsl;
> @@ -1105,9 +1105,9 @@ static int openpic_cpu_write_internal(void *opaque, gpa_t addr,
>   			mpic_irq_raise(opp, dst, ILR_INTTGT_INT);
>   		}
>
> -		spin_unlock(&opp->lock);
> +		raw_spin_unlock(&opp->lock);
>   		kvm_notify_acked_irq(opp->kvm, 0, notify_eoi);
> -		spin_lock(&opp->lock);
> +		raw_spin_lock(&opp->lock);
>
>   		break;
>   	}
> @@ -1182,12 +1182,12 @@ void kvmppc_mpic_set_epr(struct kvm_vcpu *vcpu)
>   	int cpu = vcpu->arch.irq_cpu_id;
>   	unsigned long flags;
>
> -	spin_lock_irqsave(&opp->lock, flags);
> +	raw_spin_lock_irqsave(&opp->lock, flags);
>
>   	if ((opp->gcr & opp->mpic_mode_mask) == GCR_MODE_PROXY)
>   		kvmppc_set_epr(vcpu, openpic_iack(opp, &opp->dst[cpu], cpu));
>
> -	spin_unlock_irqrestore(&opp->lock, flags);
> +	raw_spin_unlock_irqrestore(&opp->lock, flags);
>   }
>
>   static int openpic_cpu_read_internal(void *opaque, gpa_t addr,
> @@ -1387,9 +1387,9 @@ static int kvm_mpic_read(struct kvm_io_device *this, gpa_t addr,
>   		return -EINVAL;
>   	}
>
> -	spin_lock_irq(&opp->lock);
> +	raw_spin_lock_irq(&opp->lock);
>   	ret = kvm_mpic_read_internal(opp, addr - opp->reg_base, &u.val);
> -	spin_unlock_irq(&opp->lock);
> +	raw_spin_unlock_irq(&opp->lock);
>
>   	/*
>   	 * Technically only 32-bit accesses are allowed, but be nice to
> @@ -1427,10 +1427,10 @@ static int kvm_mpic_write(struct kvm_io_device *this, gpa_t addr,
>   		return -EOPNOTSUPP;
>   	}
>
> -	spin_lock_irq(&opp->lock);
> +	raw_spin_lock_irq(&opp->lock);
>   	ret = kvm_mpic_write_internal(opp, addr - opp->reg_base,
>   				      *(const u32 *)ptr);
> -	spin_unlock_irq(&opp->lock);
> +	raw_spin_unlock_irq(&opp->lock);
>
>   	pr_debug("%s: addr %llx ret %d val %x\n",
>   		 __func__, addr, ret, *(const u32 *)ptr);
> @@ -1501,14 +1501,14 @@ static int access_reg(struct openpic *opp, gpa_t addr, u32 *val, int type)
>   	if (addr & 3)
>   		return -ENXIO;
>
> -	spin_lock_irq(&opp->lock);
> +	raw_spin_lock_irq(&opp->lock);
>
>   	if (type == ATTR_SET)
>   		ret = kvm_mpic_write_internal(opp, addr, *val);
>   	else
>   		ret = kvm_mpic_read_internal(opp, addr, val);
>
> -	spin_unlock_irq(&opp->lock);
> +	raw_spin_unlock_irq(&opp->lock);
>
>   	pr_debug("%s: type %d addr %llx val %x\n", __func__, type, addr, *val);
>
> @@ -1545,9 +1545,9 @@ static int mpic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>   		if (attr32 != 0 && attr32 != 1)
>   			return -EINVAL;
>
> -		spin_lock_irq(&opp->lock);
> +		raw_spin_lock_irq(&opp->lock);
>   		openpic_set_irq(opp, attr->attr, attr32);
> -		spin_unlock_irq(&opp->lock);
> +		raw_spin_unlock_irq(&opp->lock);
>   		return 0;
>   	}
>
> @@ -1592,9 +1592,9 @@ static int mpic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
>   		if (attr->attr > MAX_SRC)
>   			return -EINVAL;
>
> -		spin_lock_irq(&opp->lock);
> +		raw_spin_lock_irq(&opp->lock);
>   		attr32 = opp->src[attr->attr].pending;
> -		spin_unlock_irq(&opp->lock);
> +		raw_spin_unlock_irq(&opp->lock);
>
>   		if (put_user(attr32, (u32 __user *)(long)attr->addr))
>   			return -EFAULT;
> @@ -1670,7 +1670,7 @@ static int mpic_create(struct kvm_device *dev, u32 type)
>   	opp->kvm = dev->kvm;
>   	opp->dev = dev;
>   	opp->model = type;
> -	spin_lock_init(&opp->lock);
> +	raw_spin_lock_init(&opp->lock);
>
>   	add_mmio_region(opp, &openpic_gbl_mmio);
>   	add_mmio_region(opp, &openpic_tmr_mmio);
> @@ -1743,7 +1743,7 @@ int kvmppc_mpic_connect_vcpu(struct kvm_device *dev, struct kvm_vcpu *vcpu,
>   	if (cpu < 0 || cpu >= MAX_CPU)
>   		return -EPERM;
>
> -	spin_lock_irq(&opp->lock);
> +	raw_spin_lock_irq(&opp->lock);
>
>   	if (opp->dst[cpu].vcpu) {
>   		ret = -EEXIST;
> @@ -1766,7 +1766,7 @@ int kvmppc_mpic_connect_vcpu(struct kvm_device *dev, struct kvm_vcpu *vcpu,
>   		vcpu->arch.epr_flags |= KVMPPC_EPR_KERNEL;
>
>   out:
> -	spin_unlock_irq(&opp->lock);
> +	raw_spin_unlock_irq(&opp->lock);
>   	return ret;
>   }
>
> @@ -1796,9 +1796,9 @@ static int mpic_set_irq(struct kvm_kernel_irq_routing_entry *e,
>   	struct openpic *opp = kvm->arch.mpic;
>   	unsigned long flags;
>
> -	spin_lock_irqsave(&opp->lock, flags);
> +	raw_spin_lock_irqsave(&opp->lock, flags);
>   	openpic_set_irq(opp, irq, level);
> -	spin_unlock_irqrestore(&opp->lock, flags);
> +	raw_spin_unlock_irqrestore(&opp->lock, flags);
>
>   	/* All code paths we care about don't check for the return value */
>   	return 0;
> @@ -1810,14 +1810,14 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>   	struct openpic *opp = kvm->arch.mpic;
>   	unsigned long flags;
>
> -	spin_lock_irqsave(&opp->lock, flags);
> +	raw_spin_lock_irqsave(&opp->lock, flags);
>
>   	/*
>   	 * XXX We ignore the target address for now, as we only support
>   	 *     a single MSI bank.
>   	 */
>   	openpic_msi_write(kvm->arch.mpic, MSIIR_OFFSET, e->msi.data);
> -	spin_unlock_irqrestore(&opp->lock, flags);
> +	raw_spin_unlock_irqrestore(&opp->lock, flags);
>
>   	/* All code paths we care about don't check for the return value */
>   	return 0;
>
