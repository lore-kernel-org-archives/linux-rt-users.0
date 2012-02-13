From: Josh Cartwright <joshc@linux.com>
Subject: Re: jffs2 filesystem: possible circular locking dependency detected
Date: Mon, 13 Feb 2012 15:02:32 -0500
Message-ID: <20120213200232.GA19958@joshcartwright.net>
References: <D61182AC8012EA4EBC531B3AF23BE109B3C6C6@tranzeo-mail2.12stewart.tranzeo.com>
 <alpine.LFD.2.02.1202082104470.2794@ionos>
 <CAN8TOE8xLdawRm9i6oTXJOE5T+MUEinkQysH9_ossikdW+8ZhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
 Darcy Watkins <DWatkins@tranzeo.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-mtd@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>
To: Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAN8TOE8xLdawRm9i6oTXJOE5T+MUEinkQysH9_ossikdW+8ZhA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Feb 10, 2012 at 10:57:54PM -0800, Brian Norris wrote:
> On Wed, Feb 8, 2012 at 12:09 PM, Thomas Gleixner <tglx@linutronix.de> wro=
te:
> > On Wed, 8 Feb 2012, Darcy Watkins wrote:
> >> [ =A0 20.932000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [ =A0 20.932000] [ INFO: possible circular locking dependency detected=
 ]
> >> [ =A0 20.932000] 3.0.18-rt34 #41
> >> [ =A0 20.932000] -----------------------------------------------------=
--
> >> [ =A0 20.932000] depmod/734 is trying to acquire lock:
> >> [ =A0 20.932000] =A0(&mm->mmap_sem){++++++}, at: [<800e82d0>] might_fa=
ult+0x4c/0xa4
> >> [ =A0 20.932000]
> >> [ =A0 20.932000] but task is already holding lock:
> >> [ =A0 20.932000] =A0(&f->sem){+.+.+.}, at: [<80184f88>] jffs2_readdir+=
0x108/0x1c0
> >> [ =A0 20.932000]
> >> [ =A0 20.932000] which lock already depends on the new lock.
> >
> > Classic ABBA deadlock. I don't think it's RT specific, but I might be
> > wrong as usual. Will have a look later this week, when noone beats me.
> =

> Looks like someone beat you :) Josh Cartwright has a patch here:
> http://lists.infradead.org/pipermail/linux-mtd/2012-February/039787.html

Unfortunately, Darcy's lockdep splat implicates a different set of
locks, so I think it is a different issue then I resolved in the linked
patch.

Looking into this one, however, I think I convinced myself that the
lockdep warning is bogus.  Here are two stack snippets that lockdep
claims would be problematic if interleaved:

do_page_fault()
   down_read(&current->mm->mmap_sem)
   /* readahead... */
      jffs2_readpage()
         mutex_lock(&JFFS2_INODE_INFO(inode)->sem)

vfs_readdir()
  /* ... */
  jffs2_readdir()
     mutex_lock(&JFFS2_INODE_INFO(inode)->sem)
     filldir()
        __put_user()
        /* fault ... */
           do_page_fault()
              down_read(&current->mm->mmap_sem)

In Darcy's case, the validator saw the do_page_fault() segment first,
and decided the lock order should be [mmap_sem, &JFFS2_INODE_INFO(inode)->s=
em].
It complained when it then saw the vfs_readdir() codepath reverse the
order [1].

This would be problematic, if it wasn't for the guarantee that the
jffs2_inode_info::sem in both paths will be different.  In the readdir()
path, the inode is the directory inode, whose i_fops doesn't even
support mmap(), and so couldn't possibly be involved in a fault().

1: Well, not exactly the same codepath, since a fault was not generated.
   put_user() includes a might_fault() which hints to lockdep that
   mmap_sem _could_ be acquired if a fault occurs.

-- =

                                           joshc

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
