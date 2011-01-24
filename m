From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: Re: Messaging
Date: Mon, 24 Jan 2011 14:32:45 -0500
Message-ID: <AANLkTikaJKhvjVg0wHqrdmj_gQ2BEB9=wcFb_tQMTu5k@mail.gmail.com>
References: <AANLkTikVO43T7NS4W4sFtZLcFKzTK1N26NHGmtcDViD+@mail.gmail.com>
	<AANLkTin-jpDKfSAEJFgMG5dYE0H5kSP3v53T3t92Erq=@mail.gmail.com>
	<AANLkTi=--R3Qjrb7iKLZa6KWZ1b19o9ZOeK2Bhd=ziZN@mail.gmail.com>
	<AANLkTi=hJh58BbMQcv3_4fzNzP49v2am2VYNFM4eHETC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-newbie@vger.kernel.org,
	Linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-kernel-mail <linux-kernel@vger.kernel.org>
To: anil joshi <anilsjoshi123@gmail.com>
Return-path: <linux-newbie-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=hJh58BbMQcv3_4fzNzP49v2am2VYNFM4eHETC@mail.gmail.com>
Sender: linux-newbie-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Anil,

    Thanks for your response. There are many implementation of
messaging in kernel. I am looking for specific implementation of Linux
kernel.
So, If I am not wrong, from your structures you posted, it seems Linux
is implementing using file system. Lets make this an assumption and
post it to groups.

Please if anyone has idea of messaging implementation, please let us kn=
ow.

Thanks,
Sri.

On Sun, Jan 23, 2011 at 3:48 PM, anil joshi <anilsjoshi123@gmail.com> w=
rote:
> I would like to share my knowledge with you =C2=A0if any technical er=
ror
> please suggest me
>
> As in Process management
>
> struct thread_info {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct task_struct =C2=A0 =C2=A0 =C2=A0*t=
ask; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* main task structure */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct exec_domain =C2=A0 =C2=A0 =C2=A0*e=
xec_domain; =C2=A0 /* execution domain */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 low level flags */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 status; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* thre=
ad synchronous flags */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* current CPU */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 preempt_count; =C2=A0/* 0 =3D> preempta=
ble,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <0 =3D> BUG */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mm_segment_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0addr_limit;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct restart_block =C2=A0 =C2=A0restart=
_block;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __user =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *sysenter_return;
> =C2=A0#ifdef CONFIG_X86_32
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 previous_esp; =C2=A0 /* ESP of the previous stack in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case of nested (IRQ) stacks
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supervisor_stack[0];
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uaccess_err;
> =C2=A0};
>
>
>
>
> struct task_struct =C2=A0{
>
> -----
> --
> -
> ----
> -----
> }
>
>
> in a similar fashion =C2=A0File System Management in that VFS
> the four Primary object of VFS are
> (courtesy =C2=A0by Robert =C2=A0Love Linux kernel Dev elopement)
> super block object =C2=A0-> represent mounted file system (contained =
in
> struct vfsmount)
> i node object -> represent a specific =C2=A0file
>
> d entry object -> represent directory entry, a single component of a =
path
> fiie object -> open file as associated with process
>
> Layered approach
> Object of struct mqueue_inode_info layered =C2=A0on Object of struct =
inode
> (vfs_inode)
>
> or
>
> Object of struct inode (vfs_inode) =C2=A0contained in struct mqueue_i=
node_info
>
>
>
> it contain particular message specific information like
>
> $ ls /dev/mqueue/mymq
> QSIZE:129 =C2=A0 =C2=A0 NOTIFY:2 =C2=A0 =C2=A0SIGNO:0 =C2=A0 =C2=A0NO=
TIFY_PID:8260
>
>
>
> struct mqueue_inode_info {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t lock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode vfs_inode;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_queue_head_t wait_q;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct msg_msg **messages;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mq_attr attr;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sigevent notify;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pid* notify_owner;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct user_struct *user; =C2=A0 =C2=A0 =C2=
=A0 /* user who created, for accounting */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sock *notify_sock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sk_buff *notify_cookie;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* for tasks waiting for free space and me=
ssages, respectively */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ext_wait_queue e_wait_q[2];
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long qsize; /* size of queue in =
memory (sum of all msgs) */
> =C2=A0};
>
> struct inode =C2=A0{
> =C2=A0----
> ----
> ----
> }
>
>
> we used the generic inode structure as the inode layer does not need
> to know about the =C2=A0/dev/mqueue/mymq stucture(mqueue_inode_info)
>
> flush
> unlnk
> look up
> mqueue_poll_file,
> mqueue_read_file
> are specific to mqueue inode
> static const struct inode_operations mqueue_dir_inode_operations =3D =
{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.lookup =3D simple_lookup,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.create =3D mqueue_create,
> =C2=A0 =C2=A0 =C2=A0 .unlink =3D mqueue_unlink,
> =C2=A0};
>
> static const struct file_operations mqueue_file_operations =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.flush =3D mqueue_flush_file,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.poll =3D mqueue_poll_file,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.read =3D mqueue_read_file,
> =C2=A0};
>
> inode->i_fop =3D &mqueue_file_operations;
> inode->i_op =3D &mqueue_dir_inode_operations;
>
>
> refer http://bec-systems.com/web/content/view/94/9/
> http://www.kroah.com/log/linux/container_of.html
>
> if u know more regarding mqueue share it
>
> Regards
> Anil.S.Joshi
>



--=20
Regards,
Sri.
--
To unsubscribe from this list: send the line "unsubscribe linux-newbie"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs
