From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch-rt] radix-tree: Partially disable memcg accounting
 in radix_tree_node_alloc()
Date: Fri, 06 Jan 2017 09:28:34 +0100
Message-ID: <1483691314.11478.11.camel@gmail.com>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
         <1483690403.11478.8.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483690403.11478.8.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Trace of the bad thing about to happen.

       madvise06-4719  [003] .......  1187.428766: handle_mm_fault <-__do_page_fault
       madvise06-4719  [003] .......  1187.428766: __rcu_read_lock <-handle_mm_fault
       madvise06-4719  [003] .......  1187.428766: mem_cgroup_from_task <-handle_mm_fault
       madvise06-4719  [003] .......  1187.428766: __rcu_read_unlock <-handle_mm_fault
       madvise06-4719  [003] .......  1187.428766: __do_fault <-handle_mm_fault
       madvise06-4719  [003] .......  1187.428766: shmem_fault <-__do_fault
       madvise06-4719  [003] .......  1187.428766: shmem_getpage_gfp <-shmem_fault
       madvise06-4719  [003] .......  1187.428766: find_lock_entry <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428766: find_get_entry <-find_lock_entry
       madvise06-4719  [003] .......  1187.428766: __rcu_read_lock <-find_get_entry
       madvise06-4719  [003] .......  1187.428766: __rcu_read_unlock <-find_get_entry
       madvise06-4719  [003] .......  1187.428766: shmem_alloc_page <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428766: mpol_shared_policy_lookup <-shmem_alloc_page
       madvise06-4719  [003] .......  1187.428766: alloc_pages_vma <-shmem_alloc_page
       madvise06-4719  [003] .......  1187.428766: get_vma_policy <-alloc_pages_vma
       madvise06-4719  [003] .......  1187.428766: __get_vma_policy <-get_vma_policy
       madvise06-4719  [003] .......  1187.428766: get_task_policy.part.40 <-alloc_pages_vma
       madvise06-4719  [003] .......  1187.428766: policy_nodemask <-alloc_pages_vma
       madvise06-4719  [003] .......  1187.428767: policy_zonelist <-alloc_pages_vma
       madvise06-4719  [003] .......  1187.428767: __alloc_pages_nodemask <-alloc_pages_vma
       madvise06-4719  [003] .......  1187.428767: get_page_from_freelist <-__alloc_pages_nodemask
       madvise06-4719  [003] .......  1187.428767: migrate_disable <-get_page_from_freelist
       madvise06-4719  [003] ....11.  1187.428767: pin_current_cpu <-migrate_disable
       madvise06-4719  [003] .....11  1187.428767: rt_spin_lock__no_mg <-get_page_from_freelist
       madvise06-4719  [003] .....11  1187.428767: __inc_zone_state <-get_page_from_freelist
       madvise06-4719  [003] .....11  1187.428767: __inc_zone_state <-get_page_from_freelist
       madvise06-4719  [003] .....11  1187.428767: rt_spin_unlock__no_mg <-get_page_from_freelist
       madvise06-4719  [003] .....11  1187.428767: migrate_enable <-get_page_from_freelist
       madvise06-4719  [003] ....11.  1187.428767: unpin_current_cpu <-migrate_enable
       madvise06-4719  [003] .......  1187.428767: mem_cgroup_try_charge <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428767: get_mem_cgroup_from_mm <-mem_cgroup_try_charge
       madvise06-4719  [003] .......  1187.428767: __rcu_read_lock <-get_mem_cgroup_from_mm
       madvise06-4719  [003] .......  1187.428767: __rcu_read_unlock <-get_mem_cgroup_from_mm
       madvise06-4719  [003] .......  1187.428767: try_charge <-mem_cgroup_try_charge
       madvise06-4719  [003] .......  1187.428767: migrate_disable <-try_charge
       madvise06-4719  [003] ....11.  1187.428768: pin_current_cpu <-migrate_disable
       madvise06-4719  [003] .....11  1187.428768: rt_spin_lock__no_mg <-try_charge
       madvise06-4719  [003] .....11  1187.428768: rt_spin_unlock__no_mg <-try_charge
       madvise06-4719  [003] .....11  1187.428768: migrate_enable <-try_charge
       madvise06-4719  [003] ....11.  1187.428768: unpin_current_cpu <-migrate_enable
       madvise06-4719  [003] .......  1187.428768: page_counter_try_charge <-try_charge
       madvise06-4719  [003] .......  1187.428768: migrate_disable <-try_charge
       madvise06-4719  [003] ....11.  1187.428768: pin_current_cpu <-migrate_disable
       madvise06-4719  [003] .....11  1187.428768: rt_spin_lock__no_mg <-try_charge
       madvise06-4719  [003] .....11  1187.428768: rt_spin_unlock__no_mg <-try_charge
       madvise06-4719  [003] .....11  1187.428768: migrate_enable <-try_charge
       madvise06-4719  [003] ....11.  1187.428768: unpin_current_cpu <-migrate_enable
       madvise06-4719  [003] .......  1187.428768: page_counter_try_charge <-try_charge
       madvise06-4719  [003] .......  1187.428768: shmem_add_to_page_cache <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428768: rt_spin_lock <-shmem_add_to_page_cache
       madvise06-4719  [003] .......  1187.428768: migrate_disable <-rt_spin_lock
       madvise06-4719  [003] ....11.  1187.428769: pin_current_cpu <-migrate_disable
       madvise06-4719  [003] .....11  1187.428769: kmem_cache_alloc <-radix_tree_node_alloc.constprop.25
       madvise06-4719  [003] .....11  1187.428769: memcg_kmem_get_cache <-kmem_cache_alloc
       madvise06-4719  [003] .....11  1187.428769: get_mem_cgroup_from_mm <-memcg_kmem_get_cache
       madvise06-4719  [003] .....11  1187.428769: __rcu_read_lock <-get_mem_cgroup_from_mm
       madvise06-4719  [003] .....11  1187.428769: __rcu_read_unlock <-get_mem_cgroup_from_mm
       madvise06-4719  [003] .....11  1187.428769: __rcu_read_lock <-memcg_kmem_get_cache
       madvise06-4719  [003] .....11  1187.428769: __rcu_read_unlock <-memcg_kmem_get_cache
       madvise06-4719  [003] .....11  1187.428769: __slab_alloc.isra.76 <-kmem_cache_alloc
       madvise06-4719  [003] d....11  1187.428769: ___slab_alloc <-__slab_alloc.isra.76
       madvise06-4719  [003] d....11  1187.428769: get_partial_node.isra.65 <-___slab_alloc
       madvise06-4719  [003] d....11  1187.428770: mempolicy_slab_node <-___slab_alloc
       madvise06-4719  [003] d....11  1187.428770: new_slab <-___slab_alloc
       madvise06-4719  [003] .....11  1187.428770: alloc_pages_current <-new_slab
       madvise06-4719  [003] .....11  1187.428770: get_task_policy.part.40 <-alloc_pages_current
       madvise06-4719  [003] .....11  1187.428770: policy_nodemask <-alloc_pages_current
       madvise06-4719  [003] .....11  1187.428770: policy_zonelist <-alloc_pages_current
       madvise06-4719  [003] .....11  1187.428770: __alloc_pages_nodemask <-alloc_pages_current
       madvise06-4719  [003] .....11  1187.428770: get_page_from_freelist <-__alloc_pages_nodemask
       madvise06-4719  [003] .....11  1187.428770: __zone_watermark_ok <-get_page_from_freelist
       madvise06-4719  [003] .....11  1187.428770: migrate_disable <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428770: rt_spin_lock__no_mg <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428770: rt_spin_lock <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428770: migrate_disable <-rt_spin_lock
       madvise06-4719  [003] .....13  1187.428771: __rmqueue <-get_page_from_freelist
       madvise06-4719  [003] .....13  1187.428771: __mod_zone_page_state <-get_page_from_freelist
       madvise06-4719  [003] .....13  1187.428771: rt_spin_unlock <-get_page_from_freelist
       madvise06-4719  [003] .....13  1187.428771: migrate_enable <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428771: __inc_zone_state <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428771: __inc_zone_state <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428771: rt_spin_unlock__no_mg <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428771: migrate_enable <-get_page_from_freelist
       madvise06-4719  [003] .....11  1187.428771: memcg_kmem_charge_memcg <-new_slab
       madvise06-4719  [003] .....11  1187.428771: try_charge <-memcg_kmem_charge_memcg
       madvise06-4719  [003] .....11  1187.428771: migrate_disable <-try_charge
       madvise06-4719  [003] .....12  1187.428771: rt_spin_lock__no_mg <-try_charge
       madvise06-4719  [003] .....12  1187.428771: rt_spin_unlock__no_mg <-try_charge
       madvise06-4719  [003] .....12  1187.428772: migrate_enable <-try_charge
       madvise06-4719  [003] .....11  1187.428772: page_counter_try_charge <-try_charge
       madvise06-4719  [003] .....11  1187.428772: migrate_disable <-try_charge
       madvise06-4719  [003] .....12  1187.428772: rt_spin_lock__no_mg <-try_charge
       madvise06-4719  [003] .....12  1187.428772: rt_spin_unlock__no_mg <-try_charge
       madvise06-4719  [003] .....12  1187.428772: migrate_enable <-try_charge
       madvise06-4719  [003] .....11  1187.428772: page_counter_try_charge <-try_charge
       madvise06-4719  [003] .....11  1187.428772: __free_pages <-new_slab
       madvise06-4719  [003] .....11  1187.428772: __free_pages_ok <-new_slab
       madvise06-4719  [003] .....11  1187.428772: migrate_disable <-__free_pages_ok
       madvise06-4719  [003] .....12  1187.428772: rt_spin_lock__no_mg <-__free_pages_ok
       madvise06-4719  [003] .....12  1187.428772: free_one_page <-__free_pages_ok
       madvise06-4719  [003] .....12  1187.428772: rt_spin_lock <-free_one_page
       madvise06-4719  [003] .....12  1187.428773: migrate_disable <-rt_spin_lock
       madvise06-4719  [003] .....13  1187.428773: node_page_state <-free_one_page
       madvise06-4719  [003] .....13  1187.428773: __mod_zone_page_state <-free_one_page
       madvise06-4719  [003] .....13  1187.428773: rt_spin_unlock <-__free_pages_ok
       madvise06-4719  [003] .....13  1187.428773: migrate_enable <-__free_pages_ok
       madvise06-4719  [003] .....12  1187.428773: rt_spin_unlock__no_mg <-__free_pages_ok
       madvise06-4719  [003] .....12  1187.428773: migrate_enable <-new_slab
       madvise06-4719  [003] .....11  1187.428773: alloc_pages_current <-new_slab
       madvise06-4719  [003] .....11  1187.428773: get_task_policy.part.40 <-alloc_pages_current
       madvise06-4719  [003] .....11  1187.428773: policy_nodemask <-alloc_pages_current
       madvise06-4719  [003] .....11  1187.428773: policy_zonelist <-alloc_pages_current
       madvise06-4719  [003] .....11  1187.428773: __alloc_pages_nodemask <-alloc_pages_current
       madvise06-4719  [003] .....11  1187.428773: get_page_from_freelist <-__alloc_pages_nodemask
       madvise06-4719  [003] .....11  1187.428773: migrate_disable <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428774: rt_spin_lock__no_mg <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428774: __inc_zone_state <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428774: __inc_zone_state <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428774: rt_spin_unlock__no_mg <-get_page_from_freelist
       madvise06-4719  [003] .....12  1187.428774: migrate_enable <-get_page_from_freelist
       madvise06-4719  [003] .....11  1187.428774: memcg_kmem_charge_memcg <-new_slab
       madvise06-4719  [003] .....11  1187.428774: try_charge <-memcg_kmem_charge_memcg
       madvise06-4719  [003] .....11  1187.428774: migrate_disable <-try_charge
       madvise06-4719  [003] .....12  1187.428774: rt_spin_lock__no_mg <-try_charge
       madvise06-4719  [003] .....12  1187.428774: rt_spin_unlock__no_mg <-try_charge
       madvise06-4719  [003] .....12  1187.428774: migrate_enable <-try_charge
       madvise06-4719  [003] .....11  1187.428774: page_counter_try_charge <-try_charge
       madvise06-4719  [003] .....11  1187.428774: migrate_disable <-try_charge
       madvise06-4719  [003] .....12  1187.428774: rt_spin_lock__no_mg <-try_charge
       madvise06-4719  [003] .....12  1187.428774: rt_spin_unlock__no_mg <-try_charge
       madvise06-4719  [003] .....12  1187.428775: migrate_enable <-try_charge
       madvise06-4719  [003] .....11  1187.428775: page_counter_try_charge <-try_charge
       madvise06-4719  [003] .....11  1187.428775: __free_pages <-new_slab
       madvise06-4719  [003] .....11  1187.428775: free_hot_cold_page <-new_slab
       madvise06-4719  [003] .....11  1187.428775: migrate_disable <-free_hot_cold_page
       madvise06-4719  [003] .....12  1187.428775: rt_spin_lock__no_mg <-free_hot_cold_page
       madvise06-4719  [003] .....12  1187.428775: rt_spin_unlock__no_mg <-free_hot_cold_page
       madvise06-4719  [003] .....12  1187.428775: migrate_enable <-free_hot_cold_page
       madvise06-4719  [003] d....11  1187.428775: slab_out_of_memory <-___slab_alloc
       madvise06-4719  [003] .....11  1187.428775: free_delayed <-__slab_alloc.isra.76
       madvise06-4719  [003] .....11  1187.428775: memcg_kmem_put_cache <-kmem_cache_alloc
       madvise06-4719  [003] .....11  1187.428775: rt_spin_unlock <-shmem_add_to_page_cache
       madvise06-4719  [003] .....11  1187.428776: migrate_enable <-shmem_add_to_page_cache
       madvise06-4719  [003] ....11.  1187.428776: unpin_current_cpu <-migrate_enable
       madvise06-4719  [003] .......  1187.428776: mem_cgroup_cancel_charge <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428776: cancel_charge <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428776: page_counter_uncharge <-cancel_charge
       madvise06-4719  [003] .......  1187.428776: page_counter_cancel <-page_counter_uncharge
       madvise06-4719  [003] .......  1187.428776: page_counter_cancel <-page_counter_uncharge
       madvise06-4719  [003] .......  1187.428776: unlock_page <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428776: __put_page <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428776: __page_cache_release <-__put_page
       madvise06-4719  [003] .......  1187.428777: mem_cgroup_uncharge <-__put_page
       madvise06-4719  [003] .......  1187.428777: free_hot_cold_page <-shmem_getpage_gfp
       madvise06-4719  [003] .......  1187.428777: migrate_disable <-free_hot_cold_page
       madvise06-4719  [003] ....11.  1187.428777: pin_current_cpu <-migrate_disable
       madvise06-4719  [003] .....11  1187.428777: rt_spin_lock__no_mg <-free_hot_cold_page
       madvise06-4719  [003] .....11  1187.428777: rt_spin_unlock__no_mg <-free_hot_cold_page
       madvise06-4719  [003] .....11  1187.428777: migrate_enable <-free_hot_cold_page
       madvise06-4719  [003] ....11.  1187.428777: unpin_current_cpu <-migrate_enable
       madvise06-4719  [003] .......  1187.428777: rt_up_read <-__do_page_fault
       madvise06-4719  [003] .......  1187.428777: rt_mutex_unlock <-__do_page_fault
       madvise06-4719  [003] .......  1187.428778: mm_fault_error <-do_page_fault
       madvise06-4719  [003] .......  1187.428778: pagefault_out_of_memory <-do_page_fault
