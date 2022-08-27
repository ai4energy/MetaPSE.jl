
abstract type AbstractVariableType end
struct VelocityType <: AbstractVariableType
    unit
    low
    up
    defautvalue
    function VelocityType()
        new("m/s",1.0, 5.0, 2.0)        
    end    
end
struct Variable{T}
    variabletype::T
    sym::Symbol
    function Variable{T}(variabletype,name) where {T<:AbstractVariableType}
        new{T}(variabletype,name)
    end        
end



Variable(variabletype,name) = Variable{typeof(variabletype)}(variabletype,name)

velocitytype=VelocityType()
Variable(velocitytype,:abcd)

Variable(VelocityType(),:abd)

#Variable{T}(variabletype,name) where {T}=new{T}(typeof(variabletype),name)


Variable(velocity,:v)

# 最好做两个宏

# @variabletype("velocity",unit, low, up, default)产生一个类型和一个类型的实例

# @variable(type,name)产生一个类型的变量和实例

Base.@kwdef struct PSEVariable
    name::Symbol
    unit::Unitful.FreeUnits #就是只能使用我们定义好的那些unit，如何来check？
    defaultvalue::Float64
    lowerbound::Float64
    upperbound::Float64
    initialgues::Float64
    #constraint要不要？
    #mktvarsym
end

#abc=PSEVariable(:abc,PSEUnits.kilomole_per_cubic_metre,1.0, 0.0, 5.0, 2.0)


struct PSEVvv{unit,defaultvalue,Lowerboundry,Upboundry} 
    name::Symbol
    function PSEVvv{unit,defaultvalue,Lowerboundry,Upboundry}(name::Symbol) where {unit,defaultvalue,Lowerboundry,Upboundry}

        new{unit,defaultvalue,Lowerboundry,Upboundry}(name)
    end

end

abc=PSEVvv{kilomole_per_cubic_metre,1.0,0.0,5.0}(:abc)
getunit(::PSEVvv{unit,defaultvalue,Lowerboundry,Upboundry}) where {unit,defaultvalue,Lowerboundry,Upboundry} = unit
getlowboundry(::PSEVvv{unit,defaultvalue,Lowerboundry,Upboundry}) where {unit,defaultvalue,Lowerboundry,Upboundry} = Lowerboundry