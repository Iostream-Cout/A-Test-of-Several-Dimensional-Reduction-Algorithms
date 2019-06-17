clear;
load('Caltech101-7.mat');
X=data{6};
ys=length(unique(labels));
dim=[100 200 300 400 500 600 700 800 900];
pca=[];kernelpca=[];lpp=[];lda=[];lle=[];lap=[];
for d=1:length(dim)
    ld=dim(d);
    
    Xlow=compute_mapping(X,'PCA',ld);
    ids=litekmeans(Xlow,ys,'replicates',3);
    result=ClusteringMeasure(ids,labels);
    pca=[pca result(1)];
    
    Xlow=compute_mapping(X,'KernelPCA',ld);
    ids=litekmeans(Xlow,ys,'replicates',3);
    result=ClusteringMeasure(ids,labels);
    kernelpca=[kernelpca result(1)];
    
    Xlow=compute_mapping(X,'LPP',ld);
    ids=litekmeans(Xlow,ys,'replicates',3);
    result=ClusteringMeasure(ids,labels);
    lpp=[lpp result(1)];
    
    Xlow=compute_mapping([labels X],'LDA',ld);
    ids=litekmeans(Xlow,ys,'replicates',3);
    result=ClusteringMeasure(ids,labels);
    lda=[lda result(1)];
    
    Xlow=compute_mapping(X,'LLE',ld);
    ids=litekmeans(Xlow,ys,'replicates',3);
    result=ClusteringMeasure(ids,labels);
    lle=[lle result(1)];
    
    Xlow=compute_mapping(X,'Laplacian',ld);
    ids=litekmeans(Xlow,ys,'replicates',3);
    result=ClusteringMeasure(ids,labels);
    lap=[lap result(1)];
end
plot(dim,pca,'r');hold on;
plot(dim,kernelpca,'g');hold on;
plot(dim,lpp,'b');hold on;
plot(dim,lda,'y');hold on;
plot(dim,lle,'k');hold on;
plot(dim,lap,'m');hold off;
legend('PCA','Kernel PCA','LPP','LDA','LLE','Laplacian');